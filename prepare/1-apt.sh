#!/usr/bin/env bash

echo "====> Install softwares via apt-get <===="

echo "==> Change mirror source"

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
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
fi
sudo mv list.tmp /etc/apt/sources.list

# Virtual machines needn't this and I want life easier.
# https://help.ubuntu.com/lts/serverguide/apparmor.html
if [ "$(whoami)" == 'vagrant' ];
then
    echo "==> Disable AppArmor"
    sudo service apparmor stop
    sudo update-rc.d -f apparmor remove
fi

echo "==> Disable whoopsie"
sudo sed -i 's/report_crashes=true/report_crashes=false/' /etc/default/whoopsie
sudo service whoopsie stop

echo "==> Install linuxbrew dependences"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential curl git m4 ruby texinfo
sudo apt-get -y install libbz2-dev zlib1g-dev
sudo apt-get -y install libcurl4-openssl-dev libexpat-dev libncurses-dev

echo "==> Install other software"
sudo apt-get -y install csh parallel vim graphviz screen unzip xsltproc numactl

echo "==> Install other software"
sudo apt-get -y install libdb-dev libreadline-dev libedit-dev
sudo apt-get -y install libgd-dev libxml2-dev

echo "==> Install gsl"
sudo apt-get -y install libgsl0ldbl libgsl0-dev

# Gtk stuff, Need by alignDB
# install them in a fresh machine to avoid problems
echo "==> Install gtk3"
sudo apt-get -y install libcairo2-dev libglib2.0-0 libglib2.0-dev libgtk-3-dev libgirepository1.0-dev
sudo apt-get -y install gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-webkit-3.0

echo "==> Install gtk3 related tools"
sudo apt-get -y install xvfb glade

echo "==> Install nautilus plugins"
sudo apt-get -y install nautilus-open-terminal nautilus-actions

# install mongodb and redis by apt
if [ "$(whoami)" == 'vagrant' ];
then
    echo "==> Install mongodb"
    sudo apt-get -y install mongodb
fi

echo "==> Install redis"
sudo apt-get -y install redis-server

# Mysql will be installed separately.
# Remove system provided mysql package to avoid confusing linuxbrew.
echo "==> Remove system provided mysql"
sudo apt-get -y purge mysql-common

echo "==> Restore original sources.list"
if [ -e /etc/apt/sources.list.bak ];
then
    sudo rm /etc/apt/sources.list
    sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi

echo "====> Basic software installation complete! <===="
