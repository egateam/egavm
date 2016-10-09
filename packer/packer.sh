#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts/egavm

if [[ `uname` == 'Darwin' ]];
then
    if [ hash packer 2>/dev/null ];
    then
        echo "==> Install packer via brew"
        brew install packer
    else
        echo "==> Found packer in PATH"
    fi
fi

echo "==> Get Ubuntu iso"
wget -N -P $BASE_DIR/prepare/resource http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-server-amd64.iso
wget -N -P $BASE_DIR/prepare/resource http://download.virtualbox.org/virtualbox/5.1.6/VBoxGuestAdditions_5.1.6.iso

echo "==> Build Ubuntu box"
cd $BASE_DIR/packer

if [ ! -e $BASE_DIR/vm/mytrusty.box ];
then
    packer build template.json
    mv mytrusty.box $BASE_DIR/vm
fi

echo "==> Add base box"
vagrant box add mytrusty $BASE_DIR/vm/mytrusty.box --force
