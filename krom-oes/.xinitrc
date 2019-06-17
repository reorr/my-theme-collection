#! /bin/bash

includes=/etc/X11/xinit/xinitrc.d
if [ -d "$includes" ]; then
	for f in "$includes/"*
	do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
unset includes

xrdb -load $HOME/.Xresources
#xautolock -time 1 -locker "betterlockscreen -l dim"
xsetroot -cursor_name left_ptr

session=${1:-ob}

case $session in
    ob|openbox	      ) exec openbox-session;;
    aho			) exec ahoviewer;;
    *                 ) exec $1;;
esac
