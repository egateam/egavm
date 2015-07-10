# Virtual machines (Vagrant boxes) for [EGA](http://ega.nju.edu.cn).

## Setting up

Normal users should not build EGA VMs themselves. We provide full functional boxes [here](http://ega.nju.edu.cn/download). If you insist to DIY, check scripts in `prepare/` and [this section](#instructions-for-building-scripts).

To use your local EGA service, following the steps below.

1. Install [Vagrant](https://www.vagrantup.com/downloads.html);
2. Pick a virtualization platform [VirtualBox](https://www.virtualbox.org/wiki/Download_Old_Builds_4_3) or [Parallels](http://www.parallels.com/products/desktop/) and install it;
    + For VirtualBox, install the Extension Pack.
    + For Parallels, install Parallels provider for vagrant
        - `vagrant plugin install vagrant-parallels`
    + [VMware provider](http://www.vagrantup.com/vmware) is not free and VMware is not used in our team, so I'm sorry for not providing VMware boxes.
3. Get configuration file for your virtualization platform by
    + cloning this repository and check [Directory structure](#directory-structure)
        - `git clone https://github.com/wang-q/egavm.git`
    + or downloading corresponding Vagrantfile for your virtualization platform and putting it in a clean directory;
4. Download `ega-vd.box` for VirtualBox or `ega-pd.box` for Parallels; Put it in the same directory of the configuration file;
5. `cd` into your project directory and run
    + `vagrant box add ega-vd ega-vd.box` for VirtualBox
    + `vagrant box add ega-pd ega-pd.box` for Parallels
6. Start EGA service.
    + `vagrant up --provider=virtualbox # start VM, change virtualbox to parallels if needed`
    + You can either 
        - `vagrant ssh # log into VM via ssh`
        - or open a terminal window in the VM GUI.
    + `cd ~/ega && node app.js` IMPORTANT! Be sure your cwd is ~/ega
7. Open your favorite browser and visit `http://localhost:30080`. Or in VM GUI, open firefox and visit `http://localhost:3000`.

## Directory structure

* `vf/`
    + Vagrantfile for users.
    + [Vagrantfile-vd](vf/Vagrantfile-vd): VirtualBox with GUI on Linux, Mac and Windows.
    + [Vagrantfile-pd](vf/Vagrantfile-pd): Parallels with GUI on Mac.
    + [Vagrantfile-v](vf/Vagrantfile-v): VirtualBox without GUI on Linux, Mac and Windows. For experienced users only.

* `prepare/`
    + Scirpts to build VMs.

* Vagrantfiles for setting up basic VM.
    + `virtualbox-desktop/`
    + `parallels-desktop/`
    + `virtualbox/`

## Instructions for building scripts

### Get public vagrant boxes

```bash
vagrant box add box-cutter/ubuntu1404 --provider virtualbox

vagrant box add box-cutter/ubuntu1404-desktop --provider virtualbox

# Mac OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
    vagrant plugin install vagrant-parallels
    vagrant box add box-cutter/ubuntu1404-desktop --provider parallels
fi
```

### Build a vagrant box from .iso.

See [packer.sh](prepare/packer.sh)

### VirtualBox desktop

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/virtualbox-desktop
vagrant up --provider=virtualbox
vagrant ssh
```

* STEPS inside VM

Disable auto updates: `System Settings -> Software and updates -> updates -> Automatically check for updates: Never`

```bash
sh /prepare/1-apt.sh

## In GUI terminal
## sh /prepare/2-unity.sh

sh /prepare/3-plenv.sh
source $HOME/.bashrc
sh /prepare/4-cpanm.sh

sh /prepare/5-clone.sh
sh /prepare/6-download.sh

sh /prepare/extra/1-apt.sh       # Optional, needed by alignDB
sh /prepare/extra/4-cpanm.sh     # Optional, needed by alignDB

sh /prepare/7-brew.sh
source $HOME/.bashrc
sh /prepare/8-node.sh

sh /prepare/extra/7-mysql51.sh   # Optional, Linuxbrew mysql51, needed by alignDB

# Build jksrc.zip once and save binary files.
# Don't do this if jkbin-ubuntu-1404-2011.tar.gz exists.
### sh /prepare/extra/8-jksrc.sh

sh /prepare/9-postinstall.sh     # Clean the System
```

* Pack VM up

```bash
vagrant package --output ega-vd.box
```

### Parallels desktop

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/parallels-desktop
vagrant up --provider=parallels
vagrant ssh
```

* STEPS inside VM

Same as virtualbox-desktop.

* Pack VM up

```bash
vagrant package --output ega-pd.box
```

### VirtualBox headless

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/virtualbox
vagrant up --provider=virtualbox
vagrant ssh
```

* STEPS inside VM

Omit `sh /prepare/2-unity.sh`, and all others is the same as virtualbox-desktop.

* Pack VM up

```bash
vagrant package --output ega-v.box
```

### Box sizes

| name                    | size             |
| :-------------          | :--------------: |
| ega-vd.box              | 1.95 GB          |
| ega-vd.box w/o optional | 1.87 GB          |
| ega-pd.box              |                  |
| ega-pd.box w/o optional |                  |
| ega-v.box               | 1.44 GB          |
| ega-v.box w/o optional  |                  |
