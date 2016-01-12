#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get -y install dkms

sudo tee -a /etc/apt/sources.list  <<EOF

# virtualbox
deb http://download.virtualbox.org/virtualbox/debian trusty contrib

EOF

wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get -y update
sudo apt-get -y install virtualbox-5.0
