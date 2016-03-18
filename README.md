[ Languages: [English](README.md), [中文](README-zh.md) ]

# Virtual machines for [EGA](http://ega.nju.edu.cn).

## Setting up

To use your local EGA service, following the steps below.

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads);
    + Current version is 5.0.16.
    + Optionally, install the extension pack.

2. Download `egavm.ova` and import it into VirtualBox;

3. Start virtual machine.

4. Open your browser and visit `http://localhost:30080`. Or inside VM GUI, open browser and visit `http://localhost:3000`.

## Setting up with vagrant

1. Same as step 1 in previous section;

2. Install [Vagrant](https://www.vagrantup.com/downloads.html);
    + Current version is 1.8.1

3. Get configuration file [`Vagrantfile`](vm/Vagrantfile) and putting it in a clean directory;

4. Download `egavm.box` and put it in the same directory of the configuration file;

5. `cd` into the previous directory and run `vagrant box add egavm egavm.box`.

6. Start virtual machine, `vagrant up`.

7. Same as step 4 in previous section;

## Directory Organization

* [`packer/`](packer/): Scirpts for building Ubuntu base box.

* [`prepare/`](prepare/): Scirpts for using vagrant to build VMs.

* [`vm/`](vm/): .box and .ova.
    * [`Vagrantfile`](vm/Vagrantfile): configuration files for users.

## Instructions for building scripts

Normal users should not build EGA VMs themselves. If you insist to DIY, check scripts in [`packer/`](packer/) and [`prepare/`](prepare/).

Be cautious, all settings for building are optimised for China.
