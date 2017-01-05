# Useful tips

## Vagrant

更新 vagrant 后, 需要重新安装额外的插件, 否则有可能无法使用.

```bash
vagrant plugin install vagrant-parallels
```

## Parallels

Parallels Virtualization SDK 需要去 Parallels
[官网](http://www.parallels.com/cn/products/desktop/download/) 下载.

## VirtualBox

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
