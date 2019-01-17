
-- Mpv Filenavigator
-- Author: donmaiq
-- Contributors: SteveJobzniak
-- URL: https://github.com/donmaiq/mpv-filenavigator
--
local settings = {
  --fallback if no file is open, should be a string that points to a path in your system
  defaultpath = os.getenv("HOME") or "/",
  forcedefault = false, --force navigation to start from defaultpath instead of currently playing file
  --favorites in format { 'Path to directory, notice trailing /' }
  favorites = {
    '/media/HDD2/music/music/',
    '/media/HDD/users/anon/Downloads/',
    '/home/anon/',
  },
  --list of paths to ignore. the value is anything that returns true for if-statement.
  --directory ignore entries must end with a trailing slash,
  --but files and all symlinks (even to dirs) must be without slash!
  --to help you with the format, simply run "ls -1p <parent folder>" in a terminal,
  --and you will see if the file/folder to ignore is listed as "file" or "folder/" (trailing slash).
  --you can ignore children without ignoring their parent.
  ignorePaths = {
    --general linux system paths (some are used by macOS too):
    ['/bin/']='1',['/boot/']='1',['/cdrom/']='1',['/dev/']='1',['/etc/']='1',['/lib/']='1',['/lib32/']='1',['/lib64/']='1',['/tmp/']='1',
    ['/srv/']='1',['/sys/']='1',['/snap/']='1',['/root/']='1',['/sbin/']='1',['/proc/']='1',['/opt/']='1',['/usr/']='1',['/run/']='1',
    --useless macOS system paths (some of these standard folders are actually files (symlinks) into /private/ subpaths, hence some repetition):
    ['/cores/']='1',['/etc']='1',['/installer.failurerequests']='1',['/net/']='1',['/private/']='1',['/tmp']='1',['/var']='1'
  },
  --ignore folders and files that match patterns regardless of where they exist on disk.
  --make sure you use ^ (start of string) and $ (end of string) to catch the whole str instead of risking partial false positives.
  --read about patterns at https://www.lua.org/pil/20.2.html or http://lua-users.org/wiki/PatternsTutorial
  ignorePatterns = {
    '^initrd%..*/?$', --hide files and folders folders starting with "initrd.<something>"
    '^vmlinuz.*/?$', --hide files and folders starting with "vmlinuz<something>"
    '^lost%+found/?$', --hide files and folders named "lost+found"
    '^.*%.log$', --ignore files with extension .log
  },

  navigator_mainkey = "Alt+f", --the key to bring up navigator's menu, can be bound on input.conf aswell
  navigator_menu_favkey = "f", --this key will always be bound when the menu is open, and is the key you use to cycle your favorites list!
  dynamic_binds = true,        --navigation keybinds override arrowkeys and enter when activating navigation menu, false means keys are always actíve
  menu_timeout = true,         --menu timeouts and closes itself after osd_dur seconds, else will be toggled by keybind
  osd_dur = 5,                 --osd duration before the navigator closes, if timeout is set to true
  osd_items_per_screen = 10,   --how many menu items to show per screen
  navigator_font_size = 40,    --the font size to use for the OSD while the navigator is open
  normal_font_size = mp.get_property("osd-font-size") --the OSD font size to return to when the navigator closes (get the osd-font-size property for default)
}


--escape a file or directory path for use in shell arguments
function escapepath(dir, escapechar)
  return string.gsub(dir, escapechar, '\\'..escapechar)
end

--ensures directories never accidentally end in "//" due to our added slash
function stripdoubleslash(dir)
  if (string.sub(dir, -2) == "//") then
    return string.sub(dir, 1, -2) --negative 2 removes the last character
  else
    return dir
  end
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return string.sub(s, 0, -2)
end

dir = nil
path = nil
cursor = 0
length = 0
--osd handler that displays your navigation and information
function handler(arg)
  add_keybinds()
  timer:kill()
  if not path then
    if mp.get_property('path') and not settings.forcedefault then
      --determine path from currently playing file...
      local workingdir = mp.get_property("working-directory")
      local playfilename = mp.get_property("filename") --just the filename, without path
      local playpath = mp.get_property("path") --can be relative or absolute depending on what args mpv was given
      local firstchar = string.sub(playpath, 1, 1)
      --first we need to remove the filename (may give us empty path if mpv was started in same dir as file)
      path = string.sub(playpath, 1, string.len(playpath)-string.len(playfilename))
      if (firstchar ~= "/") then --the path of the playing file wasn't absolute, so we need to add mpv's working dir to it
        path = workingdir.."/"..path
      end
      --now resolve that path (to resolve things like "/home/anon/Movies/../Movies/foo.mkv")
      path = resolvedir(path)
      --lastly, check if the folder exists, and if not then fall back to the current mpv working dir
      if (not isfolder(path)) then
        path = workingdir
      end
    else path = settings.defaultpath end
    dir,length = scandirectory(path)
  end
  local output = path.."\n\n"
  local b = cursor - math.floor(settings.osd_items_per_screen / 2)
  if b > 0 then output=output.."...\n" end
  if b<0 then b=0 end
  for a=b,(b+settings.osd_items_per_screen),1 do
    if a==length then break end
    if a == cursor then
      entry="> "..dir[a].." <"
      if arg == "added" then entry = entry .." + added to playlist\n"
      elseif arg == "removed" then entry = entry.." - removed previous addition\n" else entry=entry.."\n" end
    else
      entry="  "..dir[a].."  \n"
    end
    entry=string.gsub(entry, " ", "\160")
    output = output..entry
    if a == (b+settings.osd_items_per_screen) then
      output=output.."..."
    end
  end
  mp.set_property("osd-font-size", settings.navigator_font_size)
  if not settings.menu_timeout then
    mp.osd_message(output, 100000)
  else
    mp.osd_message(output, settings.osd_dur)
    timer:resume()
  end
end

function navdown()
  if cursor~=length-1 then
    cursor = cursor+1
  else
    cursor = 0
  end
  handler()
end

function navup()
  if cursor~=0 then
    cursor = cursor-1
  else
    cursor = length-1
  end
  handler()
end

--moves into selected directory, or appends to playlist incase of file
function childdir()
  local item = dir[cursor]
  if item then
    if isfolder(path..item) then
      local newdir = stripdoubleslash(path..dir[cursor].."/")
      changepath(newdir)
    else
      mp.commandv("loadfile", path..item, "append-play")
      handler("added")
    end
  end
end

--undo playlist file append
function undo()
  mp.commandv("playlist-remove", tonumber(mp.get_property('playlist-count'))-1)
  handler("removed")
end

--close OSD and restore regular font size, and remove bindings
function clearosd()
  mp.osd_message("", 0.2)
  mp.set_property("osd-font-size", settings.normal_font_size)
  remove_keybinds()
end

--replace current playlist with directory or file
--if directory, mpv will recursively queue all items found in the directory and its subfolders
function opendir()
  local item = dir[cursor]
  if item then
    clearosd()
    mp.commandv("loadfile", path..item, "replace")
  end
end

--changes the directory to the path in argument
function changepath(args)
  path = args
  dir,length = scandirectory(path)
  cursor=0
  handler()
end

--move up to the parent directory
function parentdir()
  --if path doesn't exist or can't be entered, this returns "/" (root of the drive) as the parent
  local parent = stripdoubleslash(os.capture('cd "'..escapepath(path, '"')..'" 2>/dev/null && cd .. 2>/dev/null && pwd').."/")
  changepath(parent)
end

--resolves relative paths such as "/home/foo/../foo/Music" (to "/home/foo/Music") if the folder exists!
function resolvedir(dir)
  local safedir = escapepath(dir, '"')
  --if dir doesn't exist or can't be entered, this returns "/" (root of the drive) as the resolved path
  local resolved = stripdoubleslash(os.capture('cd "'..safedir..'" 2>/dev/null && pwd').."/")
  return resolved
end

--true if path exists and is a folder, otherwise false
function isfolder(dir)
  local lua51returncode, _, lua52returncode = os.execute('test -d "'..escapepath(dir, '"')..'"')
  return lua51returncode == 0 or lua52returncode == 0
end

function scandirectory(searchdir)
  local directory = {}
  --list all files, using universal utilities and flags available on both Linux and macOS
  --  ls: -1 = list one file per line, -p = append "/" indicator to the end of directory names, -v = display in natural order
  --  stderr messages are ignored by sending them to /dev/null
  --  hidden files ("." prefix) are skipped, since they exist everywhere and never contain media
  --  if we cannot list the contents (due to no permissions, etc), this returns an empty list
  local popen, err = io.popen('ls -1vp "'..escapepath(searchdir, '"')..'" 2>/dev/null')
  local i = 0
  if popen then
    for direntry in popen:lines() do
      local matchedignore = false
      for k,pattern in pairs(settings.ignorePatterns) do
        if direntry:find(pattern) then
          matchedignore = true
          break --don't waste time scanning further patterns
        end
      end
      if not matchedignore and not settings.ignorePaths[path..direntry] then
        directory[i] = direntry
        i=i+1
      end
    end
    popen:close()
  else
    mp.msg.error("Could not scan for files :"..(err or ""))
  end
  return directory, i
end

favcursor = 1
function cyclefavorite()
  local firstpath = settings.favorites[1]
  if not firstpath then return end
  local favpath = nil
  local favlen = 0
  for key, fav in pairs(settings.favorites) do
    favlen = favlen + 1
    if key == favcursor then favpath = fav end
  end
  if favpath then
    changepath(favpath)
    favcursor = favcursor + 1
  else
    changepath(firstpath)
    favcursor = 2
  end
end

function add_keybinds()
  mp.add_forced_key_binding("DOWN", "nav-down", navdown, "repeatable")
  mp.add_forced_key_binding("UP", "nav-up", navup, "repeatable")
  mp.add_forced_key_binding("ENTER", "nav-open", opendir)
  mp.add_forced_key_binding("BS", "nav-undo", undo)
  mp.add_forced_key_binding("RIGHT", "nav-forward", childdir)
  mp.add_forced_key_binding("LEFT", "nav-back", parentdir)
  mp.add_forced_key_binding(settings.navigator_menu_favkey, "nav-favorites", cyclefavorite)
end

function remove_keybinds()
  if settings.dynamic_binds then
    mp.remove_key_binding('nav-down')
    mp.remove_key_binding('nav-up')
    mp.remove_key_binding('nav-open')
    mp.remove_key_binding('nav-undo')
    mp.remove_key_binding('nav-forward')
    mp.remove_key_binding('nav-back')
    mp.remove_key_binding('nav-favorites')
  end
end
timer = mp.add_periodic_timer(settings.osd_dur, clearosd)
timer:kill()
if not settings.dynamic_binds then
  add_keybinds()
end

active=false
function activate()
  if settings.menu_timeout then
    handler()
  else
    if active then
      clearosd()
      active=false
    else
      handler()
      active=true
    end
  end
end

mp.add_key_binding(settings.navigator_mainkey, "navigator", activate)
