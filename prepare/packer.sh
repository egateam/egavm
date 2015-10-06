#!/usr/bin/env bash

echo "Don't execute this script."
echo "Open it in a text editor then execute line by line."
echo
exit 1

export BASE_DIR=$HOME/Scripts/egavm/prepare

echo "==> Install packer via brew cask"
brew cask install packer

cd $BASE_DIR

echo "==> Get Ubuntu iso"
cd $BASE_DIR/ubuntu
mkdir -p $BASE_DIR/iso
cd $BASE_DIR/iso
wget -N http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.3/ubuntu-14.04.3-server-amd64.iso

echo "==> Get Ubuntu template"
git clone https://github.com/boxcutter/ubuntu

# Network connection is needed, may take tens of minutes.
echo "==> Build"
cd $BASE_DIR/ubuntu
rm $BASE_DIR/ubuntu/box/virtualbox/*.box
echo "ISO_PATH := file://$BASE_DIR/iso" > Makefile.local
make virtualbox/ubuntu1404-desktop

mv $BASE_DIR/ubuntu/box/virtualbox/ubuntu1404-desktop*.box $BASE_DIR/resource

cd $BASE_DIR/resource
vagrant box add ubuntu1404-desktop*.box --name box-cutter/ubuntu1404-desktop

# cd /Users/wangq/Scripts/windows
# packer build -only=virtualbox-iso -var 'cm=nocm' -var 'version=1.0.4' -var 'update=false' -var 'headless=false' -var "shutdown_command=shutdown /s /t 10 /f /d p:4:1 /c Packer_Shutdown" -var "iso_url=/Users/wangq/Downloads/en_windows_7_professional_with_sp1_vl_build_x64_dvd_u_677791.iso" -var "iso_checksum=708e0338d4e2f094dfeb860347c84a6ed9e91d0c" win7x64-pro-ssh.json
# packer build -only=parallels-iso -var 'cm=nocm' -var 'version=1.0.4' -var 'update=false' -var 'headless=false' -var "shutdown_command=shutdown /s /t 10 /f /d p:4:1 /c Packer_Shutdown" -var "iso_url=/Users/wangq/Downloads/en_windows_7_professional_with_sp1_vl_build_x64_dvd_u_677791.iso" -var "iso_checksum=708e0338d4e2f094dfeb860347c84a6ed9e91d0c" win7x64-pro-ssh.json
