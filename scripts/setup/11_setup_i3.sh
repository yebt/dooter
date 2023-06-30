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
# Remember activate the service
# sudo systemctl enable betterlockscreen@
# # # move service file to proper dir (the aur package does this for you)
# cp betterlockscreen@.service /usr/lib/systemd/system/

# # enable systemd service
# systemctl enable betterlockscreen@$USER

# # disable systemd service
# systemctl disable betterlockscreen@$USER

# # Note: Now you can call systemctl suspend to suspend your system
# # and betterlockscreen service will be activated
# # so when your system wakes your screen will be locked.

