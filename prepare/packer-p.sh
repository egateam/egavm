#!/usr/bin/env bash

VG_DIR='/Users/wangq/Scripts/egavm/prepare'

echo "Don't execute this script."
echo "Open it in a text editor then execute line by line."
echo
exit 1

### STEPS on my Mac host machine

# Install Vagrant and Parallels manually
# https://www.vagrantup.com/downloads.html
# http://www.parallels.com/products/desktop/

# Install packer via brew cask
brew cask install packer

#
cd $VG_DIR
wget http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.2/ubuntu-14.04.2-server-amd64.iso

# install Parallels provider for vagrant
vagrant plugin install vagrant-parallels

# Ubuntu template
git clone https://github.com/boxcutter/ubuntu
cd $VG_DIR/ubuntu
echo "ISO_PATH := file://$VG_DIR" > Makefile.local
echo "CM := nocm" >> Makefile.local
#rm box/parallels/ubuntu1404-nocm-*.box
make parallels/ubuntu1404
vagrant box add ub1404-p box/parallels/ubuntu1404-nocm-*.box

cd $VG_DIR/../parallels

vagrant up --provider=parallels
vagrant ssh

### STEPS inside ubuntu 14.04 VM

cd ~
sh /vagrant/software.sh
sh /vagrant/plenv.sh
sh /vagrant/clone.sh

# leave VM
exit

###
cd ~/vagrant
vagrant package --output egavm-p.box
