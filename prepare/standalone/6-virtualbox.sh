#!/usr/bin/env bash

echo "==> dkms"
sudo apt-get -y update
sudo apt-get -y install dkms

echo "==> virtualbox"
sudo tee -a /etc/apt/sources.list  <<EOF

# virtualbox
deb http://download.virtualbox.org/virtualbox/debian trusty contrib

EOF

wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get -y update
sudo apt-get -y install virtualbox-5.0

echo "==> packer"
mkdir -p ~/bin
wget -N -P /prepare/resource https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip
unzip /prepare/resource/packer_*_linux_amd64.zip -d ~/bin

echo "==> vagrant"
wget -N -P /prepare/resource https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
sudo dpkg -i /prepare/resource/vagrant_1.8.1_x86_64.deb
