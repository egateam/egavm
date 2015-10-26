# Instructions for building scripts

## Software versions

* Ubuntu:       14.04.3
* VirtualBox:   5.0.6
* Vagrant:      1.7.4

## Build Ubuntu base box with packer from .iso

See [packer.sh](prepare/packer.sh) or [trusty64.sh](prepare/trusty64.sh)

OR

## Get public vagrant boxes for Ubuntu 14.04.3

```bash
vagrant box add box-cutter/ubuntu1404-desktop --provider virtualbox --box-version 2.0.5
vagrant box add box-cutter/ubuntu1404 --provider virtualbox --box-version 2.0.5
```

##  Vagrantfiles for setting up basic VM.

* `prepare/virtualbox/`
* `prepare/virtualbox-headless/`
* `prepare/virtualbox-trusty64/`

## VirtualBox desktop

* STEPS on host machine

This would download a fresh Ubuntu vm and take several minutes.

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox
vagrant up --provider=virtualbox
vagrant ssh
```

* STEPS inside VM

Username and password are `vagrant` and `vagrant`, respectively.

In GUI desktop, disable auto updates: `System Settings -> Software and updates -> updates`,
set `Automatically check for updates: Never`, untick all checkboxes, click close and click close again.

```bash
bash /prepare/1-apt.sh | tee log-1-apt.txt

echo "==> Press master button (Win for Windows and right Command for Mac) and type `terminal` to start a GUI terminal"
 ## bash /prepare/2-unity.sh

bash /prepare/3-plenv.sh
source $HOME/.bashrc
bash /prepare/4-cpanm.sh | tee log-4-cpanm.txt

bash /prepare/5-clone.sh
bash /prepare/6-download.sh

bash /prepare/extra/4-cpanm.sh  # Optional, needed by alignDB

 # linuxbrew's pkg-config will conflict system wide $PKG_CONFIG_PATH, so put them to the tail of job queues.
bash /prepare/7-brew.sh | tee log-7-brew.txt
source $HOME/.bashrc
bash /prepare/8-node.sh

bash /prepare/extra/7-mysql.sh              # Optional, compiling full mysql51.
 # bash /prepare/extra/7-mysql-client.sh     # Optional, Linuxbrew mysql51 client, needed by alignDB and building jksrc.
source $HOME/.bashrc                        # After installation, add user alignDB to mysql.

 # Build jksrc.zip once and save binary files.
 # Don't do this if jkbin-ubuntu-1404-2011.tar.gz exists.
 ### bash /prepare/extra/8-jksrc.sh

bash /prepare/extra/9-ensembl.sh  # Optional, needed by alignDB

bash /prepare/9-postinstall.sh    # Clean the System
```

* Pack VM up

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox
vagrant package --output egavm.box
du -hs egavm.box
```

## VirtualBox headless

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox-headless
vagrant up --provider=virtualbox
vagrant ssh
```

* STEPS inside VM

Omit `prepare/2-unity.sh`, and all others are the same as virtualbox-desktop.

* Pack VM up

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox-headless
vagrant package --output egavm-headless.box
du -hs egavm-headless.box
```

## VirtualBox trusty64

This build starts from official Ubuntu 14.04 [vagrant box](https://cloud-images.ubuntu.com/vagrant/trusty/current/).

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox-trusty64
bash ../trusty64.sh
rm -fr .vagrant/
vagrant up
vagrant halt

echo "==> Resize hard driver"
DISK_FILE=`VBoxManage showvminfo egavm-build | grep vmdk | perl -n -e '/($ENV{HOME}.+)\(UUID/; $file = $1; print $file'`
DISK_DIR=`dirname "${DISK_FILE}"`
echo ${DISK_FILE}
echo ${DISK_DIR}
cd "${DISK_DIR}"

VBoxManage clonehd "box-disk1.vmdk" "clone-disk1.vdi" --format vdi
VBoxManage modifyhd "clone-disk1.vdi" --resize 102400
VBoxManage showvminfo egavm-build | grep "Storage"
VBoxManage storageattach egavm-build --storagectl "SATAController" --port 0 --device 0 --type hdd --medium clone-disk1.vdi

cd $HOME/Scripts/egavm/prepare/virtualbox-trusty64
vagrant up
vagrant ssh
```

* STEPS inside VM

Install Ubuntu desktop and upgrade VirtualBox guest additions.

```bash
echo "==> Install Ubuntu desktop"
bash /prepare/1-apt.sh | tee log-1-apt.txt
bash /prepare/10-desktop.sh | tee log-10-desktop.txt

echo "==> Upgrade VirtualBox guest additions"

cd $HOME
sudo m-a prepare
wget -N http://download.virtualbox.org/virtualbox/5.0.6/VBoxGuestAdditions_5.0.6.iso
sudo mount VBoxGuestAdditions_5.0.6.iso -o loop /mnt
cd /mnt
sudo sh VBoxLinuxAdditions.run --nox11
cd $HOME
rm *.iso
sudo /etc/init.d/vboxadd setup
sudo update-rc.d vboxadd defaults


echo "==> Check that Guest Editions are installed"
lsmod | grep vboxguest

exit
```

* Back to host machine

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox-trusty64
vagrant reload
vagrant ssh
```

* Log into VM

Now you have a GUI desktop.

```bash
echo "Press master button (Win for Windows and right Command for Mac) and type `terminal` to start a GUI terminal"
bash /prepare/2-unity.sh
```

All others are the same as virtualbox-desktop.

* Pack VM up

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox-headless
vagrant package --output egavm-headless.box
du -hs egavm-headless.box
```

## Box sizes

| name               | size    |
| :-----             | :-----: |
| egavm.box          | 2.1 GB  |
| egavm-headless.box | 1.4 GB  |
