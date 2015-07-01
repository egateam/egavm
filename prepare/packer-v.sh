#!/usr/bin/env bash

VG_DIR='/Users/wangq/Scripts/egavm/prepare'

echo "Don't execute this script."
echo "Open it in a text editor then execute line by line."
echo
exit 1

### STEPS on my Mac host machine

# Install Vagrant and Parallels manually
# https://www.vagrantup.com/downloads.html
# https://www.virtualbox.org/wiki/Downloads

# Install packer via brew cask
brew cask install packer

#
cd $VG_DIR
wget http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.2/ubuntu-14.04.2-server-amd64.iso

# Ubuntu template
git clone https://github.com/boxcutter/ubuntu
cd $VG_DIR/ubuntu
echo "ISO_PATH := file://$VG_DIR" > Makefile.local
echo "CM := nocm" >> Makefile.local
#rm box/virtualbox/ubuntu1404-nocm-*.box
make virtualbox/ubuntu1404
vagrant box add ub1404-v box/virtualbox/ubuntu1404-nocm-*.box

cd $VG_DIR/../virtualbox

vagrant up --provider=virtualbox
vagrant ssh

### STEPS inside VM

sh /prepare/1-apt.sh
sh /prepare/2-brew.sh
source ~/.bashrc
sh /prepare/3-plenv.sh
source ~/.bashrc
sh /prepare/4-cpanm.sh
sh /prepare/5-clone.sh

# config repeatmasker

# leave VM
exit

### pack the VM
cd $VG_DIR/../virtualbox
vagrant package --output egavm-v.box
