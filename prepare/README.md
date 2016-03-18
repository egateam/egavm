# Instructions for building scripts

## Software versions

* Ubuntu:       14.04.4
* VirtualBox:   5.0.16
* Vagrant:      1.8.1
* Packer:       0.10.0

## Build Ubuntu base box with packer from .iso

See [`packer/`](packer/) and [`packer/README.md`](packer/README.md).

## Vagrantfiles for setting up VM

* `prepare/virtualbox/Vagrantfile`

## VM rules

* The building VM's name is `egavm-build` and the user VM's is `egavm`.
* Perl is managed by plenv, version 5.18.4.
* Dependant libs of Perl modules are installed by apt-get.
    * zlib
    * gsl
    * BerkeleyDB
    * GD
    * libxml2
    * gtk3
* R and mongodb are installed by apt-get in VM (by linuxbrew in standalone machine).
* Node.js and most bioinformatics softwares (including blast+) are install by linuxbrew.
* Jim Kent's utils are installed to `~/bin`.
* Blast (the old one, not blast+), circos and mysql are installed to `~/share`.
* All ega related things are placed in `~/Scripts`.

## VirtualBox VM building steps

This build starts from `mytrusty.box`.

When internet connection is OK and most source files were downloaded previously, 
the building process costs about 100 minutes.

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox
vagrant destroy -f
rm -fr .vagrant/

echo "You may need remove orphan disks first if you have modifyhd. VirtualBox->File->Virtual Media Manager."

cd $HOME/Scripts/egavm/prepare/virtualbox

echo "Change resolution"
vagrant up --provider virtualbox
VBoxManage controlvm egavm-build setvideomodehint 1024 768 32

vagrant ssh
```

* STEPS inside VM

Now you have a GUI desktop.

Username and password are `vagrant` and `vagrant`, respectively.

In GUI desktop, disable auto updates: `System Settings -> Software & updates -> Updates`,
set `Automatically check for updates: Never`, untick all checkboxes, click close and click close again.

`2-unity.sh` removes nautilus bookmarks and disables lock screen.

```bash
echo "==> Install Ubuntu packages"
echo "==> When some packages went wrong, check http://mirrors.ustc.edu.cn/ubuntu/ for updating status."
bash /prepare/1-apt.sh | tee log-1-apt.txt

echo '==> Press master key (`Win` for Windows and right `Command` for Mac) and type `terminal` to start a GUI terminal'
echo '==> Or `Ctrl+Alt+T` to start a GUI terminal'
bash /prepare/2-unity.sh

echo '==> Return host machine and `vagrant reload && vagrant ssh`'
exit

bash /prepare/3-plenv.sh
source $HOME/.bashrc

bash /prepare/4-cpanm.sh | tee log-4-cpanm.txt
bash /prepare/extra/4-cpanm.sh | tee log-extra-4-cpanm.txt  # Optional, needed by alignDB

bash /prepare/5-clone.sh
bash /prepare/6-download.sh

# linuxbrew's pkg-config conflicts with system wide $PKG_CONFIG_PATH, so put them to the tail of job queues.
bash /prepare/7-brew.sh | tee log-7-brew.txt
source $HOME/.bashrc
bash /prepare/8-node.sh

bash /prepare/extra/7-mysql.sh              # Optional, compiling full mysql51.
# bash /prepare/extra/7-mysql-client.sh     # Optional, Linuxbrew mysql51 client, needed by alignDB and building jksrc.
source $HOME/.bashrc                        # After installation, add user alignDB to mysql.

# Build jksrc.zip once and save binary files.
# Don't do this if jkbin-ubuntu-1404-2011.tar.gz exists.
### bash /prepare/extra/8-jksrc.sh

bash /prepare/extra/9-ensembl.sh    # Optional, needed by alignDB

bash /prepare/9-pm2.sh

rm $HOME/log*.txt                   # review and delete all logs

bash /prepare/10-postinstall.sh     # Clean the System

exit
```

* Pack VM up

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox
vagrant halt
vagrant package --output egavm.box
mv egavm.box $HOME/Scripts/egavm/vm
```

* Create `egavm.ova`

```bash
cd $HOME/Scripts/egavm/vm
vagrant destroy -f

vagrant box add egavm egavm.box --force
vagrant up --provider virtualbox

vagrant halt
VBoxManage export egavm -o egavm.ova
```

## Box sizes

`du -hs ~/Scripts/egavm/vm/*`

| name         | size    |
| :-----       | :-----: |
| egavm.box    | 1.9 GB  |
| egavm.ova    | 1.9 GB  |
| mytrusty.box | 966 MB  |

## Useful tips

* Resize hard driver

```bash
echo "You may need remove existing disks in VirtualBox catalog first, VirtualBox->File->Virtual Media Manager."

cd $HOME/Scripts/egavm/prepare/virtualbox
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
```

* Manually install/upgrade VirtualBox guest additions

```bash
echo "==> Install VirtualBox guest additions"
sudo m-a prepare

wget -N -P /prepare/resource http://download.virtualbox.org/virtualbox/5.0.12/VBoxGuestAdditions_5.0.12.iso
sudo mount /prepare/resource/VBoxGuestAdditions_5.0.12.iso -o loop /mnt
cd /mnt
echo "yes" | sudo sh VBoxLinuxAdditions.run --nox11 # type yes

sudo /etc/init.d/vboxadd setup
sudo update-rc.d vboxadd defaults

echo "==> Check that Guest Editions are installed"
lsmod | grep vboxguest

sudo reboot
```
