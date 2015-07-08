#!/usr/bin/env bash

BASE_DIR='/Users/wangq/Scripts/egavm'

echo "Don't execute this script."
echo "Open it in a text editor then execute line by line."
echo
exit 1

vagrant box add box-cutter/ubuntu1404 --provider virtualbox

vagrant box add box-cutter/ubuntu1404-desktop --provider virtualbox

# Mac OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
    vagrant plugin install vagrant-parallels
    vagrant box add box-cutter/ubuntu1404-desktop --provider parallels
fi

### STEPS on host machine

cd $BASE_DIR/virtualbox-desktop
vagrant up --provider=virtualbox
vagrant ssh

### STEPS inside VM

sh /prepare/1-apt.sh
sh /prepare/2-brew.sh
sh /prepare/3-plenv.sh
sh /prepare/4-cpanm.sh
sh /prepare/5-clone.sh

# leave VM
exit

### pack the VM
vagrant package --output ega-vd.box
