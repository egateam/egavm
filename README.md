# Virtual machines (Vagrant boxes) for [EGA](http://ega.nju.edu.cn).

## Setting up

Normal users should not build EGA VMs themselves. We provide full functional boxes [here](http://ega.nju.edu.cn/download). If you insist to DIY, check scripts in `prepare/`.

To use your local EGA service, following the steps below.

1. Install [Vagrant](https://www.vagrantup.com/downloads.html);
2. Pick a virtualization platform [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or [Parallels](http://www.parallels.com/products/desktop/) and install it;
    + For Parallels, install Parallels provider for vagrant
        - `vagrant plugin install vagrant-parallels`
    + [VMware provider](http://www.vagrantup.com/vmware) is not free and VMware is not used in our team, so I'm sorry for not providing VMware boxes.
3. Get configuration file for your virtualization platform by
    + cloning this repository
        - `git clone https://github.com/wang-q/egavm.git`
    + or downloading corresponding Vagrantfile for your virtualization platform and putting it in a clean directory;
4. Download `egavm-v.box` for VirtualBox or `egavm-p.box` for Parallels; Put it in the same directory of the configuration file;
5. `cd` into your project directory and run
    + `vagrant box add egavm-v egavm-v.box` for VirtualBox
    + `vagrant box add egavm-p egavm-p.box` for Parallels
6. Start EGA service.
    + `vagrant up --provider=virtualbox # start VM, change virtualbox to parallels if needed`
    + `vagrant ssh # log into VM`
    + `node ega/app.js # now your terminal is in the VM`
7. Open your favorite browser and visit `http://localhost:30080`.

## Directory structure

* `prepare/`
    + Scirpts to build VMs.

* `virtualbox/`
    + VirtualBox on Linux, Mac and Windows.

* `parallels/`
    + Parallels on Mac.
