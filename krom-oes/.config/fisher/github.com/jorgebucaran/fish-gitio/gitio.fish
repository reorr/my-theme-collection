set -g gitio_version 1.0.1

function gitio -d "Create a Git.io URL (git.io/<code>)"
    switch "$argv"
        case {,-}-v{ersion,}
            echo gitio version $gitio_version
        case {,-}-h{elp,} ""
            echo "usage: gitio [<code>=]<url>   Create a Git.io URL (git.io/<code>)"
            echo "       gitio --help           Display this help"
            echo "       gitio --version        Display the current version"
            echo "examples:"
            echo "       gitio https://github.com/user/repo"
            echo "       gitio repo=https://github.com/user/repo"
            echo "       gitio ball=https://codeload.github.com/user/repo/tar.gz/master"
            echo "       gitio boot=https://raw.githubusercontent.com/user/repo/v2/boot"
        case \*
            if set -q argv[2]
                echo "gitio: invalid argument count -- use \"gitio code=url\"" >&2
                return 1
            end

            command awk -v s="$argv" '
                BEGIN {
                    url = (s ~ /^https:\/\/.+/) ? s : (i = index(s, "=")) ? substr(s, i + 1) : s
                    if (i && !(code = substr(s, 1, i - 1))) exit

                    is_valid_code = !code || (length(code) <= 50 && code ~ /^[A-Za-z0-9.,+!*\'()$@_-]+$/)
                    is_valid_url = url ~ /^https:\/\/(github|(gist|raw)\.githubusercontent|(gist|codeload)\.github)\.com\/[^ \t]+$/

                    if (is_valid_url && is_valid_code) print url,code
                }
            ' | read -l url code

            if not set -q url[1]
                echo "gitio: invalid URL or code \"$argv\"" >&2
                return 1
            end

            set -l opts -si https://git.io --data-urlencode "url=$url"
            if test ! -z "$code"
                set opts $opts --data-urlencode code="$code"
            end

            set -l short (command curl $opts | command awk -v code="$code" -v error=3 '
                /^HTTP\/1\.1 422/ { exit error = 2 }
                /^HTTP\/1\.1 503/ { exit error = 3 }
                /^Location:/ {
                    print gsub("\r", "", $2) ? $2 : $2
                    exit (error = code && "https://git.io/"code != $2)
                }
                END { exit error }
            ')
            or begin
                switch $status
                    case 1
                        echo "gitio: $url already has a short URL \"$short\"" >&2
                    case 2
                        echo "gitio: https://git.io/$code is not available -- try a different code" >&2
                    case \*
                        echo "gitio: service unavailable -- are you offline?" >&2
                end
                return 1
            end
            echo $short
    end
end
