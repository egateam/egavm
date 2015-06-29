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

### STEPS inside ubuntu 14.04 VM

sh /prepare/software.sh
sh /prepare/brew.sh
sh /prepare/plenv.sh
sh /prepare/clone.sh

# config repeatmasker

# leave VM
exit

### pack the vm
cd $VG_DIR/../virtualbox
vagrant package --output egavm-v.box
