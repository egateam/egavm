[ Languages: [English](README.md), [中文](README-zh.md) ]

# Virtual machines for [EGA](http://ega.nju.edu.cn).

## Setting up

To use your local EGA service, following the steps below.

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads);
    + Current version is 5.0.6.
    + VirtualBox [Mac](http://download.virtualbox.org/virtualbox/5.0.6/VirtualBox-5.0.6-103037-OSX.dmg), [Windows](http://download.virtualbox.org/virtualbox/5.0.6/VirtualBox-5.0.6-103037-Win.exe).
    + Optionally, install [the extension pack](http://download.virtualbox.org/virtualbox/5.0.6/Oracle_VM_VirtualBox_Extension_Pack-5.0.6-103037.vbox-extpack)

2. Download `egavm.ova` and import it into VirtualBox;

3. Start virtual machine.

4. Open your browser and visit `http://localhost:30080`. Or inside VM GUI, open browser and visit `http://localhost:3000`.

## Setting up with vagrant

1. Same as step 1 in previous section;

2. Install [Vagrant](https://www.vagrantup.com/downloads.html);
    + Current version is 1.7.4

3. Get configuration file [`Vagrantfile`](vf/Vagrantfile) and putting it in a clean directory;

4. Download `egavm.box` and put it in the same directory of the configuration file;

5. `cd` into the previous directory and run `vagrant box add egavm egavm.box`.

6. Start virtual machine, `vagrant up`.

7. Same as step 4 in previous section;

## Directory Organization

* [`vf/`](vf/): configuration files for users.
    * [`Vagrantfile`](vf/Vagrantfile): VirtualBox on Linux, Mac and Windows.

* [`packer/`](packer/): Scirpts for building Ubuntu base box.

* [`prepare/`](prepare/): Scirpts for using vagrant to build VMs.

* [`vm/`](vm/): .box and .ova, should be empty.

## Instructions for building scripts

Normal users should not build EGA VMs themselves. If you insist to DIY, check scripts in [`packer/`](packer/) and [`prepare/`](prepare/).

Be cautious, all settings for building are optimised for China.
