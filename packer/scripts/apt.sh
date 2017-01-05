#!/usr/bin/env bash

echo "==> Switch to ustc mirror"

# https://lug.ustc.edu.cn/wiki/mirrors/help/ubuntu
cat <<EOF > list.tmp
# USTC_MIRRORS
deb http://mirrors.ustc.edu.cn/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse

EOF

if [ ! -e /etc/apt/sources.list.bak ];
then
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
fi
mv list.tmp /etc/apt/sources.list

echo "==> Installing Ubunutu desktop"
apt-get update -y
apt-get upgrade -y

# need these after all
apt-get install -y build-essential module-assistant curl git m4 ruby texinfo

# needed by virtualbox guest additions
apt-get install -y linux-headers-$(uname -r)

apt-get install -y --no-install-recommends ubuntu-desktop
apt-get install -y gnome-terminal firefox xrdp
apt-get install -y unity-lens-applications unity-lens-files
apt-get install -y --no-install-recommends indicator-applet-complete indicator-session

# GUI default login
mkdir -p /etc/lightdm
mkdir -p /etc/gdm

tee -a /etc/gdm/custom.conf <<EOF
[daemon]
# Enabling automatic login
AutomaticLoginEnable=True
AutomaticLoginEnable=vagrant

EOF

tee -a /etc/lightdm/lightdm.conf <<EOF
[SeatDefaults]
# Enabling automatic login
autologin-user=vagrant

EOF

echo "==> Disabling screen blanking"
mkdir -p /etc/xdg/autostart
tee -a /etc/xdg/autostart/nodpms.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=xset -dpms s off s noblank s 0 0 s noexpose
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=nodpms
Name=nodpms
Comment[en_US]=
Comment=

EOF

echo "==> Restore original sources.list"
if [ -e /etc/apt/sources.list.bak ];
then
    rm /etc/apt/sources.list
    mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi

reboot
sleep 60
