## Left Prompt
function fish_prompt
    # Set the annoying greeting to empty
    set fish_greeting
    set -l last_status $status
    # Show the current working directory
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    #echo -n ' › '
    #echo -n ' ››› '
    #echo -n ' • '
    #echo -n ' ‣▸▶ '
    #echo -n ' ▶▶▶ '
    #echo -n ' ᐅ '
    #echo -n ' ⁍ '
    #echo -n ' ◇◈⁍◆ '
    #echo -n ' » '
    set color white
    echo -n ' » '
    #set color green
    #echo -n '»'
    #set color blue
    #echo -n '» '
    set_color normal
end

## Right Prompt
function fish_right_prompt
    set_color white
    echo -n (date +"%H:%M")
    set_color normal
end

## Window title
function fish_title
    echo -n 'fish in '
    prompt_pwd
end

## Coloring
set fish_color_autosuggestion black
set fish_color_command normal
set fish_color_comment black
set fish_color_cwd blue
set fish_color_cwd_root red
set fish_color_end magenta
set fish_color_error yellow
set fish_color_escape cyan
set fish_color_history_current cyan
set fish_color_host normal
set fish_color_match blue
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param blue
set fish_color_quote green
set fish_color_redirection blue
set fish_color_search_match --background=black
set fish_color_selection blue
set fish_color_status red
set fish_color_user red
set fish_pager_color_completion blue
set fish_pager_color_description yellow
set fish_pager_color_prefix cyan
set fish_pager_color_progress cyan

## Aliases
alias wm='sudo wifi-menu -o wlp3s0'
alias mati='poweroff'
alias konek='ping 1.1.1.1'
alias musik='ncmpcpp -c ~/.ncmpcpp/ncmpcpp-albumart'
alias noalbum='ncmpcpp -c .ncmpcpp/ncmpcpp-noalbumart'
alias albumviz='ncmpcpp -c .ncmpcpp/ncmpcpp-albumartviz -S visualizer'
alias ob='startx ~/.xinitrc ob'
alias winc='startx ~/.xinitrc wc'
alias dn='sudo /opt/dnscrypt-proxy/dnscrypt.sh'
alias nh='nhentai --cbz --rm-origin-dir'
alias aria2c='aria2c --seed-time=0'

## Keybinding
set fish_key_bindings fish_default_key_bindings
