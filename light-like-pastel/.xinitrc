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
sh $HOME/.fehbg
#udiskie 

session=${1:-ob}

case $session in
    i3|i3wm           ) exec i3;;
    kde               ) exec startkde;;
    xfce	      ) exec startxfce4;;
    xfwm|xfwm4        ) exec xfwm4-session.sh;;
    ob|openbox	      ) exec openbox-session;;
    aho			) exec `ahoviewer`;;
    wc			) exec `windowchef -c $HOME/.config/windowchef/windowchefrc`;;
    gnome		) exec gnome-session;;
    #No known session, try to run it as command
    *                 ) exec $1;;
esac
