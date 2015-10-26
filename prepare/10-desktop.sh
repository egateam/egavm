#!/usr/bin/env bash

echo "==> Installing ubunutu-desktop"
sudo apt-get install -y --no-install-recommends ubuntu-desktop
sudo apt-get install -y gnome-terminal firefox xrdp
sudo apt-get install -y unity-lens-applications unity-lens-files
sudo apt-get install -y --no-install-recommends indicator-applet-complete indicator-session

sudo mkdir -p /etc/lightdm
sudo mkdir -p /etc/gdm

sudo tee -a /etc/gdm/custom.conf <<EOF
[daemon]
# Enabling automatic login
AutomaticLoginEnable=True
AutomaticLoginEnable=$(whoami)

EOF

sudo tee -a /etc/lightdm/lightdm.conf <<EOF
[SeatDefaults]
# Enabling automatic login
autologin-user=$(whoami)

EOF

