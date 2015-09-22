#!/usr/bin/env bash

BASE_DIR='$HOME/Scripts/egavm/prepare'

echo "Don't execute this script."
echo "Open it in a text editor then execute line by line."
echo
exit 1

### VirtualBox

# Install Vagrant and VirtualBox manually.
# Don't forget install VirtualBox Extension Pack.
# https://www.vagrantup.com/downloads.html
# https://www.virtualbox.org/wiki/Downloads

# Install packer via brew cask
brew cask install packer

#
cd $BASE_DIR
wget -N http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.3/ubuntu-14.04.3-desktop-amd64.iso
wget -N http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.3/ubuntu-14.04.3-server-amd64.iso

# Ubuntu template
git clone https://github.com/boxcutter/ubuntu
cd $BASE_DIR/ubuntu
echo "ISO_PATH := file://$BASE_DIR" > Makefile.local
echo "CM := nocm" >> Makefile.local
#rm box/virtualbox/ubuntu1404-nocm-*.box
make virtualbox/ubuntu1404
