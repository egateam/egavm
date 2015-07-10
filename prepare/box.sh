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

cd $HOME/Scripts/egavm/virtualbox-desktop
vagrant up --provider=virtualbox
vagrant ssh

### STEPS inside VM (virtualbox-desktop)

# In the following steps,
# #   means needed by alignDB;
# ##  means needed by VMs with GUI;
# ### means only do this once;

## Disable auto updates
## System Settings -> Software and updates -> updates -> Automatically check for updates: Never

sh /prepare/1-apt.sh
## In GUI terminal
## sh /prepare/2-unity.sh
sh /prepare/3-plenv.sh
source $HOME/.bashrc
sh /prepare/4-cpanm.sh
sh /prepare/5-clone.sh
sh /prepare/6-download.sh
# sh /prepare/extra/1-apt.sh
# sh /prepare/extra/4-cpanm.sh
sh /prepare/7-brew.sh
source $HOME/.bashrc
sh /prepare/8-node.sh
# sh /prepare/extra/7-mysql51.sh
### sh /prepare/extra/8-jksrc.sh # Don't do this if jkbin-ubuntu-1404-2011.tar.gz exists.
sh /prepare/9-postinstall.sh

# leave VM
exit

### pack the VM
# virtualbox-desktop, just ega
#vagrant package --output ega-vd.box # 1.87 GB

# execute the extra lines to run alignDB
vagrant package --output ega-vd.box # 1.95 GB

### parallels-desktop
cd $HOME/Scripts/egavm/parallels-desktop
vagrant up --provider=parallels

# ...
# ...

vagrant package --output ega-v.box # 1.44 GB

### virtualbox headless
cd $HOME/Scripts/egavm/virtualbox-desktop
vagrant up --provider=virtualbox

# ...
# ...

vagrant package --output ega-v.box # 1.44 GB
