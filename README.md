[ Languages: [English](README.md), [中文](README-zh.md) ]

# Virtual machines (Vagrant boxes) for [EGA](http://ega.nju.edu.cn).

## Setting up

To use your local EGA service, following the steps below.

1. Install [Vagrant](https://www.vagrantup.com/downloads.html);
    + Current version is 1.7.4

2. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and the extension pack;
    + Current version is 5.0.4.
    + VirtualBox [Windows](http://download.virtualbox.org/virtualbox/5.0.4/VirtualBox-5.0.4-102546-Win.exe), [Mac](http://download.virtualbox.org/virtualbox/5.0.4/VirtualBox-5.0.4-102546-OSX.dmg).
    + [The extension pack](http://download.virtualbox.org/virtualbox/5.0.4/Oracle_VM_VirtualBox_Extension_Pack-5.0.4-102546.vbox-extpack)

3. Get configuration file by
    + cloning this repository and check [Directory structure](#directory-structure)
        - `git clone https://github.com/wang-q/egavm.git`
    + or downloading the corresponding [Vagrantfile](vf/Vagrantfile) and putting it in a clean directory;

4. Download `egavm.box` and put it in the same directory of the configuration file;

5. `cd` into your project directory and run
    + `vagrant box add egavm egavm.box` for VirtualBox

6. Start EGA service.
    + `vagrant up --provider=virtualbox # start VM`
    + You can either
        - `vagrant ssh # log into VM via ssh`
        - or open a terminal window in the VM GUI.
    + `cd ~/Scripts/ega && node app.js` IMPORTANT! Be sure your cwd is `~/Scripts/ega`

7. Open your favorite browser and visit `http://localhost:30080`. Or inside VM GUI, open browser and visit `http://localhost:3000`.

## Directory structure

* `vf/`: configuration files for users.
    + [Vagrantfile](vf/Vagrantfile): VirtualBox on Linux, Mac and Windows.
    + [Vagrantfile-headless](vf/Vagrantfile-headless): VirtualBox without GUI on Linux, Mac and Windows. For experienced users only.

* `prepare/`: Scirpts to build VMs.

## Instructions for building scripts

Normal users should not build EGA VMs themselves. If you insist to DIY, check scripts in [`prepare/`](prepare/).

Be cautious, all settings for building are optimised for China.
