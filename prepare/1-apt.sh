#!/usr/bin/env bash

# softwares via apt-get
echo "====> Install softwares via apt-get <===="

echo "==> Change mirror source"
sudo sed -i 's/us.archive.ubuntu.com/mirrors.ustc.edu.cn/' /etc/apt/sources.list
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/' /etc/apt/sources.list

# I want life easier.
# https://help.ubuntu.com/lts/serverguide/apparmor.html
echo "==> Disable AppArmor"
sudo service apparmor stop
sudo update-rc.d -f apparmor remove

echo "==> Install linuxbrew dependences"
sudo apt-get -y update
#sudo apt-get -y upgrade # Avoid grub updates. Leave linux-base updates to GUI.
sudo apt-get -y install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev

echo "==> Install java"
sudo apt-get -y install openjdk-7-jre openjdk-7-jdk ant

echo "==> Install other softwares"
sudo apt-get -y install parallel vim graphviz screen unzip libdb-dev libedit-dev libgd-dev libreadline-dev libpng-dev libxml2-dev

echo "==> Install mongodb"
sudo apt-get install -y mongodb

echo "==> Install redis"
sudo apt-get -y install redis-server

echo "==> Remove system provided mysql"
sudo apt-get -y purge mysql-common

echo "Basic software installation complete!"
