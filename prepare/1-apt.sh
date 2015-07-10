#!/usr/bin/env bash

# softwares via apt-get
echo "====> Install softwares via apt-get -"

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

# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
# When GFW going on a rampage, let apt use host's shadowsocks
# sudo vim /etc/apt/apt.conf
# Acquire::socks::proxy "socks5://10.0.1.5:1080/";
echo "==> Install mongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get -y update
sudo apt-get install -y mongodb-org

echo "==> Install redis"
sudo apt-get -y install redis-server

echo "==> Remove system provided mysql"
sudo apt-get -y purge mysql-common

echo "Basic software installation complete!"
