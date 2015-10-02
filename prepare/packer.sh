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
rm `brew --cache`/*.incomplete
cp ~/Downloads/packer_0.8.6_darwin_amd64.zip `brew --cache`/packer-0.8.6.zip
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

# cd /Users/wangq/Scripts/windows
# packer build -only=virtualbox-iso -var 'cm=nocm' -var 'version=1.0.4' -var 'update=false' -var 'headless=false' -var "shutdown_command=shutdown /s /t 10 /f /d p:4:1 /c Packer_Shutdown" -var "iso_url=/Users/wangq/Downloads/en_windows_7_professional_with_sp1_vl_build_x64_dvd_u_677791.iso" -var "iso_checksum=708e0338d4e2f094dfeb860347c84a6ed9e91d0c" win7x64-pro-ssh.json
# packer build -only=parallels-iso -var 'cm=nocm' -var 'version=1.0.4' -var 'update=false' -var 'headless=false' -var "shutdown_command=shutdown /s /t 10 /f /d p:4:1 /c Packer_Shutdown" -var "iso_url=/Users/wangq/Downloads/en_windows_7_professional_with_sp1_vl_build_x64_dvd_u_677791.iso" -var "iso_checksum=708e0338d4e2f094dfeb860347c84a6ed9e91d0c" win7x64-pro-ssh.json
