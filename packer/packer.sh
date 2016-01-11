#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts/egavm

echo "==> Install packer via brew cask"
brew cask install packer

echo "==> Get Ubuntu iso"
cd $BASE_DIR/prepare/resource
wget -N http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.3/ubuntu-14.04.3-server-amd64.iso
wget -N http://download.virtualbox.org/virtualbox/5.0.12/VBoxGuestAdditions_5.0.12.iso

echo "==> Build Ubuntu box"
cd $BASE_DIR/packer

if [ ! -e $BASE_DIR/vm/mytrusty.box ];
then
    packer build template.json
    mv mytrusty.box $BASE_DIR/vm
fi

echo "==> Add base box"
vagrant box add mytrusty $BASE_DIR/vm/mytrusty.box --force
