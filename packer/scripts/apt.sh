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
cat /etc/apt/sources.list.bak >> /etc/apt/sources.list

echo "==> Installing ubunutu desktop"
apt-get update -y
apt-get upgrade -y

apt-get install -y --no-install-recommends ubuntu-desktop
apt-get install -y gnome-terminal firefox xrdp
apt-get install -y unity-lens-applications unity-lens-files
apt-get install -y --no-install-recommends indicator-applet-complete indicator-session

# needed by virtualbox guest additions
apt-get install -y build-essential module-assistant linux-headers-$(uname -r)

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
