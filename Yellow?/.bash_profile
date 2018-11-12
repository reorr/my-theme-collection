#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#  exec ob
#fi

if [ -n "$GTK_MODULES" ]; then
  GTK_MODULES="${GTK_MODULES}:appmenu-gtk-module"
else
  GTK_MODULES="appmenu-gtk-module"
fi

export GTK_MODULES
export PATH="$HOME/.bin:$PATH"
