#!/usr/bin/env bash

# softwares via apt-get
echo "====> Install softwares via apt-get <===="

if grep -q -i USTC_MIRRORS /etc/apt/sources.list; then
    echo "==> sources.list already contains USTC_MIRRORS"
else
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

    if [ ! -e /etc/apt/sources.list.bak ]
    then
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    fi
    sudo mv list.tmp /etc/apt/sources.list
    sudo cat /etc/apt/sources.list.bak >> /etc/apt/sources.list
fi



# Virtual machines needn't this and I want life easier.
# https://help.ubuntu.com/lts/serverguide/apparmor.html
if [ "$(whoami)" == "vagrant" ]; then
    echo "==> Disable AppArmor"
    sudo service apparmor stop
    sudo update-rc.d -f apparmor remove
fi

echo "==> Install linuxbrew dependences"
sudo apt-get -y update
#sudo apt-get -y upgrade # Avoid grub and linux-base updates.
sudo apt-get -y install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev

echo "==> Install java"
sudo apt-get -y install openjdk-7-jre openjdk-7-jdk ant

echo "==> Install other softwares"
sudo apt-get -y install parallel vim graphviz screen unzip libdb-dev libedit-dev libgd-dev libreadline-dev libpng-dev libxml2-dev

echo "==> Install gsl"
sudo apt-get -y install libgsl0ldbl libgsl0-dev

echo "==> Install r"
sudo apt-get -y install r-base-dev

# Gtk stuff, Need by alignDB
# install them at a fresh machine to avoid problems
echo "==> Install gtk3"
sudo apt-get -y install libcairo2-dev libglib2.0-0 libglib2.0-dev libgtk-3-dev libgirepository1.0-dev
sudo apt-get -y install gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-webkit-3.0

echo "==> Install gtk3 related tools"
sudo apt-get -y install xvfb glade

# install mongodb and redis by apt.
if [ "$(whoami)" == "vagrant" ]; then
    echo "==> Install mongodb"
    sudo apt-get -y install mongodb
fi

echo "==> Install redis"
sudo apt-get -y install redis-server

# mysql will be installed seperately.
# remove system provided mysql package to avoid confusing linuxbrew.
echo "==> Remove system provided mysql"
sudo apt-get -y purge mysql-common

if [ -n "$DISPLAY" ]; then
    echo "==> Install nautilus plugins"
    sudo apt-get -y install nautilus-open-terminal nautilus-actions
fi

echo "Basic software installation complete!"
