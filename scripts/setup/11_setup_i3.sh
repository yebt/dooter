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
	light \
	redshift \
	redshift-gtk \
	nomacs \
	feh \
	zathura \
	zathura-cb \
	zathura-devel \
	zathura-djvu \
	zathura-pdf-mupdf \
	zathura-pdf-poppler \
	zathura-plugins-all \
	xinput \
	polkit-gnome \
	-y
# Better locker
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

