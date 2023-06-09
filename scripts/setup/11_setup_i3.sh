#!/bin/bash
# i3wm
sudo dnf install \
	picom \
	i3 \
	xset \
	dunst \
	nitrogen \
	scrot \
	autorandr \
	xrandr \
	arandr \
	make \
	-y
# Better locker
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

