#!/bin/bash

# add udev rule:
# KERNEL=="card0", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="<path to .Xauthority>", RUN+="<path to script>"

#echo "" >> /home/thomas/monitor-test

export DISPLAY=:0
export XAUTHORITY=/home/thomas/.Xauthority

previous=""
xrandr -q | grep connected | while read -r line; do
	name=$(echo $line | cut -d " " -f1)
	state=$(echo $line | cut -d " " -f2)
	
	#echo "$name is $state" >> /home/thomas/monitor-test

	if [ $state = "disconnected" ]; then
		xrandr --output $name --auto
		continue
	fi
	
	if [ $name = "LVDS" ]; then
		previous=$name
		continue
	else
		xrandr --output $name --auto --right-of $previous
		#echo "$name is right of $previous" >> /home/thomas/monitor-test
		previous=$name
	fi
done

