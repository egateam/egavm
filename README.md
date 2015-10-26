[ Languages: [English](README.md), [中文](README-zh.md) ]

# Virtual machines for [EGA](http://ega.nju.edu.cn).

## Setting up

To use your local EGA service, following the steps below.

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads);
    + Current version is 5.0.6.
    + VirtualBox [Mac](http://download.virtualbox.org/virtualbox/5.0.6/VirtualBox-5.0.6-103037-OSX.dmg), [Windows](http://download.virtualbox.org/virtualbox/5.0.6/VirtualBox-5.0.6-103037-Win.exe).
    + Optionally, install [the extension pack](http://download.virtualbox.org/virtualbox/5.0.6/Oracle_VM_VirtualBox_Extension_Pack-5.0.6-103037.vbox-extpack)

2. Download `egavm.ova` and import it into VirtualBox;

3. Start virtual machine and open a terminal window in the VM GUI.
   
4. Type or paste `cd ~/Scripts/ega && node app.js` in virtual machine terminal window.

5. Open your browser and visit `http://localhost:30080`. Or inside VM GUI, open browser and visit `http://localhost:3000`.

## Setting up with vagrant

1. Same as step 1 in previous section;

2. Install [Vagrant](https://www.vagrantup.com/downloads.html);
    + Current version is 1.7.4

3. Get configuration file [`Vagrantfile`](vf/Vagrantfile) and putting it in a clean directory;

4. Download `egavm.box` and put it in the same directory of the configuration file;

5. `cd` into the previous directory and run `vagrant box add egavm egavm.box`.

6. Start virtual machine.
    + Start VM
        - `vagrant up`
    + You can either
        - log into VM via ssh `vagrant ssh`
        - or open a terminal window in the VM GUI.
        
7. Start EGA service.
    + Now you're inside the VM. IMPORTANT! Be sure your cwd is `~/Scripts/ega`.
        - `cd ~/Scripts/ega && node app.js`

8. Same as step 5 in previous section;

## Directory Organization

* [`vf/`](vf/): configuration files for users.
    + [`Vagrantfile`](vf/Vagrantfile): VirtualBox on Linux, Mac and Windows.
    + [`Vagrantfile-headless`](vf/Vagrantfile-headless): VirtualBox without GUI on Linux, Mac and Windows. For experienced users only.

* [`prepare/`](prepare/): Scirpts to build VMs.

## Instructions for building scripts

Normal users should not build EGA VMs themselves. If you insist to DIY, check scripts in [`prepare/`](prepare/).

Be cautious, all settings for building are optimised for China.
