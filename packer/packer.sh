#!/usr/bin/env bash

export BASE_DIR=$HOME/Scripts/egavm

echo "==> Install packer via brew cask"
brew cask install packer

echo "==> Get Ubuntu iso"
cd $BASE_DIR/prepare/resource
wget -N http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.3/ubuntu-14.04.3-server-amd64.iso

echo "==> Build Ubuntu box"
cd $BASE_DIR/packer

if [ ! -e mytrusty.box ];
then
    packer build template.json
fi

echo "==> Add base box"
vagrant box add mytrusty mytrusty.box --force
