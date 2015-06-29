#!/usr/bin/env bash

# softwares via apt-get
echo " - Install softwares via apt-get -"

echo " + Change mirror source"
sudo sed -i 's/us.archive.ubuntu.com/mirrors.ustc.edu.cn/' /etc/apt/sources.list

echo " + Install linuxbrew dependences"
sudo apt-get -y update
sudo apt-get -y install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev

echo " + Install java (jre)"
sudo apt-get -y install openjdk-7-jre

echo " + Install other softwares"
sudo apt-get -y install vim graphviz libdb-dev

# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
echo " + Install mongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get -y update
sudo apt-get install -y mongodb-org

echo " + Install redis"
sudo apt-get -y install redis-server

echo "Basic software installation complete!"
