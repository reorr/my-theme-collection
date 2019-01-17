-- notify.lua -- Desktop notifications for mpv.
-- Just put this file into your ~/.mpv/lua folder and mpv will find it.
--
-- Copyright (c) 2014 Roland Hieber
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-------------------------------------------------------------------------------
-- helper functions
-------------------------------------------------------------------------------

function print_debug(s)
	-- print("DEBUG: " .. s) -- comment out for no debug info
	return true
end

-- url-escape a string, per RFC 2396, Section 2
function string.urlescape(str)
	local s, c = string.gsub(str, "([^A-Za-z0-9_.!~*'()/-])",
		function(c)
			return ("%%%02x"):format(c:byte())
		end)
	return s;
end

-- escape string for html
function string.htmlescape(str)
	local str = string.gsub(str, "<", "&lt;")
	str = string.gsub(str, ">", "&gt;")
	str = string.gsub(str, "&", "&amp;")
	str = string.gsub(str, "\"", "&quot;")
	str = string.gsub(str, "'", "&apos;")
	return str
end

-- escape string for shell inclusion
function string.shellescape(str)
	return "'"..string.gsub(str, "'", "'\"'\"'").."'"
end

-- converts string to a valid filename on most (modern) filesystems
function string.safe_filename(str)
	local s, _ = string.gsub(str, "([^A-Za-z0-9_.-])",
		function(c)
			return ("%02x"):format(c:byte())
		end)
	return s;
end

-------------------------------------------------------------------------------
-- here we go.
-------------------------------------------------------------------------------

local http = require("socket.http")
http.TIMEOUT = 3
http.USERAGENT = "mpv-notify/0.1"

local posix = require("posix")

local CACHE_DIR = os.getenv("XDG_CACHE_HOME")
CACHE_DIR = CACHE_DIR or os.getenv("HOME").."/.cache"
CACHE_DIR = CACHE_DIR.."/mpv/coverart"
print_debug("making " .. CACHE_DIR)
os.execute("mkdir -p -- " .. string.shellescape(CACHE_DIR))

function tmpname()
	local _, fname = posix.mkstemp(CACHE_DIR .. "/rescale.XXXXXX")
	return fname
end

-- scale an image file
-- @return boolean of success
function scale_image(src, dst)
	local convert_cmd = ("convert -scale x64 -- %s %s"):format(
		string.shellescape(src), string.shellescape(dst))
	print_debug("executing " .. convert_cmd)
	if os.execute(convert_cmd) then
		return true
	end
	return false
end

-- look for a list of possible cover art images in the same folder as the file
-- @param absolute filename name of currently played file, or nil if no match
function get_folder_cover_art(filename)
	if not filename or string.len(filename) < 1 then
		return nil
	end

	print_debug("get_folder_cover_art: filename is " .. filename)

	local cover_extensions = { "png", "jpg", "jpeg", "gif" }
	local cover_names = { "cover", "folder", "front", "back", "insert" }

	local path = string.match(filename, "^(.*/)[^/]+$")

	for _,name in pairs(cover_names) do
		for _,ext in pairs(cover_extensions) do
			morenames = { name, string.upper(name),
				string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2, -1) }
			moreexts = { ext, string.upper(ext) }
			for _,name in pairs(morenames) do
				for _,ext in pairs(moreexts) do
					local fn = path .. name .. "." .. ext
					--print_debug("get_folder_cover_art: trying " .. fn)
					local f = io.open(fn, "r")
					if f then
						f:close()
						print_debug("get_folder_cover_art: match at " .. fn)
						return fn
					end
				end
			end
		end
	end
	return nil
end

-- fetch cover art from MusicBrainz/Cover Art Archive
-- @return file name of downloaded cover art, or nil in case of error
-- @param mbid optional MusicBrainz release ID
function fetch_musicbrainz_cover_art(artist, album, mbid)
	print_debug("fetch_musicbrainz_cover_art parameters:")
	print_debug("artist: " .. artist)
	print_debug("album: " .. album)
	print_debug("mbid: " .. mbid)

	if not artist or artist == "" or not album or album == "" then
		print("not enough metadata, not fetching cover art.")
		return nil
	end

	local output_filename = string.safe_filename(artist .. "_" .. album)
	output_filename = (CACHE_DIR .. "/%s.png"):format(output_filename)

	-- TODO: dirty hack, may only work on Linux.
	f, err = io.open(output_filename, "r")
	if f then
		print_debug("file is already in cache: " .. output_filename)
		return output_filename  -- exists and is readable
	elseif string.find(err, "[Pp]ermission denied") then
		print(("cannot read from cached file %s: %s"):format(output_filename, err))
		return nil
	end
	print_debug("fetching album art to " .. output_filename)

	local valid_mbid = function(s)
		return s and string.len(s) > 0 and not string.find(s, "[^0-9a-fA-F-]")
	end

	-- fetch release MBID from MusicBrainz, needed for Cover Art Archive
	if not valid_mbid(mbid) then
		string.gsub(artist, '"', "")
		local query = ("%s AND artist:%s"):format(album, artist)
		local url = "http://musicbrainz.org/ws/2/release?limit=1&query="
			.. string.urlescape(query)
		print_debug("fetching " .. url)
		local d, c, h = http.request(url)
		-- poor man's XML parsing:
		local mbid = string.match(d or "",
			"<%s*release%s+[^>]*id%s*=%s*['\"]%s*([0-9a-fA-F-]+)%s*['\"]")
		if not mbid or not valid_mbid(mbid) then
			print("MusicBrainz returned no match.")
			if d then
                print_debug("content: " .. d)
            end
			return nil
		end
	end
	print_debug("got MusicBrainz ID " .. mbid)

	-- fetch image from Cover Art Archive
	local url = ("http://coverartarchive.org/release/%s/front-250"):format(mbid)
	print("fetching album cover from " .. url)
	local d, c, h = http.request(url)
	if c ~= 200 then
		print(("Cover Art Archive returned HTTP %s for MBID %s"):format(c, mbid))
		return nil
	end
	if not d or string.len(d) < 1 then
		print(("Cover Art Archive returned no content for MBID %s"):format(mbid))
		print_debug("HTTP response: " .. d)
		return nil
	end

	local tmp_filename = tmpname()
	local f = io.open(tmp_filename, "w+")
	f:write(d)
	f:flush()
	f:close()

	-- make it a nice size
	if scale_image(tmp_filename, output_filename) then
		if not os.remove(tmp_filename) then
			print("could not remove" .. tmp_filename .. ", please remove it manually")
		end
		return output_filename
	end

	print(("could not scale %s to %s"):format(tmp_filename, output_filename))
	return nil
end

function notify_current_track()
	local data = mp.get_property_native("metadata")
	if not data then
		return
	end

	function get_metadata(data, keys)
		for _,v in pairs(keys) do
			if data[v] and string.len(data[v]) > 0 then
				return data[v]
			end
		end
		return ""
	end
	-- srsly MPV, why do we have to do this? :-(
	local artist = get_metadata(data, {"artist", "ARTIST"})
	local album = get_metadata(data, {"album", "ALBUM"})
	local album_mbid = get_metadata(data, {"MusicBrainz Album Id",
		"MUSICBRAINZ_ALBUMID"})
	local title = get_metadata(data, {"title", "TITLE", "icy-title"})

	print_debug("notify_current_track: relevant metadata:")
	print_debug("artist: " .. artist)
	print_debug("album: " .. album)
	print_debug("album_mbid: " .. album_mbid)

	local summary = ""
	local body = ""
	local params = ""
	local scaled_image = ""
	local delete_scaled_image = false

	-- first try finding local cover art
	local abs_filename = os.getenv("PWD") .. "/" .. mp.get_property_native("path")
	local cover_image = get_folder_cover_art(abs_filename)
	if cover_image and cover_image ~= "" then
		scaled_image = tmpname()
        scale_image(cover_image, scaled_image)
		delete_scaled_image = false
	end

	-- then load cover art from the internet
	if (not scaled_image or scaled_image == "")
	   and ((artist ~= "" and album ~= "") or album_mbid ~= "") then
		scaled_image = fetch_musicbrainz_cover_art(artist, album, album_mbid)
		cover_image = scaled_image
	end

	if scaled_image and string.len(scaled_image) > 1  then
		print("found cover art in " .. cover_image)
		params = " -i " .. string.shellescape(scaled_image)
	end

	if(artist == "") then
		summary = string.shellescape("Now playing:")
	else
		summary = string.shellescape(string.htmlescape(artist))
	end
	if title == "" then
		body = string.shellescape(mp.get_property_native("filename"))
	else
		if album == "" then
			body = string.shellescape(string.htmlescape(title))
		else
			body = string.shellescape(("%s<br /><i>%s</i>"):format(
				string.htmlescape(title), string.htmlescape(album)))
		end
	end

	local command = ("notify-send -a mpv %s -- %s %s"):format(params, summary, body)
	print_debug("command: " .. command)
	os.execute(command)

	if delete_scaled_image and not os.remove(scaled_image) then
		print("could not remove" .. scaled_image .. ", please remove it manually")
	end
end

function notify_metadata_updated(name, data)
	notify_current_track()
end


-- insert main() here

mp.register_event("file-loaded", notify_current_track)
-- mp.observe_property("metadata", nil, notify_metadata_updated)