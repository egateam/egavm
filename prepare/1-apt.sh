#!/usr/bin/env bash

# softwares via apt-get
echo "====> Install softwares via apt-get <===="

# Virtual machines needn't this and I want life easier.
# https://help.ubuntu.com/lts/serverguide/apparmor.html
if [ `whoami` == 'vagrant' ];
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
sudo apt-get -y install build-essential module-assistant linux-headers-$(uname -r)
sudo apt-get -y install curl git m4 ruby texinfo
sudo apt-get -y install libbz2-dev zlib1g-dev
sudo apt-get -y install libcurl4-openssl-dev libexpat-dev libncurses-dev

echo "==> Install java"
sudo apt-get -y install openjdk-7-jre openjdk-7-jdk ant

echo "==> Install other softwares"
sudo apt-get -y install csh parallel vim graphviz screen unzip xsltproc numactl
sudo apt-get -y install libdb-dev libreadline-dev libedit-dev
sudo apt-get -y install libgd-dev libxml2-dev

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
if [[ `whoami` == 'vagrant' ]];
then
    echo "==> Install mongodb"
    sudo apt-get -y install mongodb
fi

echo "==> Install redis"
sudo apt-get -y install redis-server

# mysql will be installed seperately.
# remove system provided mysql package to avoid confusing linuxbrew.
echo "==> Remove system provided mysql"
sudo apt-get -y purge mysql-common

echo "Basic software installation complete!"
