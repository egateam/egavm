# Instructions for building scripts

## Software versions

* Ubuntu: 14.04.6
* VirtualBox: 6.0.4
* Vagrant: 2.2.4
* Packer: v1.3.5

## Build Ubuntu base box `mytrusty.box` with packer from .iso

See [`packer/`](../packer/) and [`packer/README.md`](../packer/README.md).

## Vagrantfiles for setting up VM

* `prepare/virtualbox/Vagrantfile`

## VirtualBox VM building steps

This build starts from `mytrusty.box`.

When internet connection is OK and most source files were downloaded previously, the building
process costs about 100 minutes.

* STEPS on host machine

```bash
cd $HOME/Scripts/egavm/prepare/virtualbox
vagrant destroy -f
rm -fr .vagrant/

echo "You might need remove orphan disks first. VirtualBox->File->Virtual Media Manager."

cd $HOME/Scripts/egavm/prepare/virtualbox

echo "Change resolution"
vagrant up --provider virtualbox
VBoxManage controlvm egavm-build setvideomodehint 1024 768 32

vagrant ssh
```

* STEPS inside VM

Now you have a GUI desktop.

Username and password are `vagrant` and `vagrant`, respectively.

In GUI desktop, disable auto updates: `System Settings -> Software & updates -> Updates`, set
`Automatically check for updates:` to `Never`, untick all checkboxes, click close and click close
again.

`2-unity.sh` removes nautilus bookmarks and disables lock screen.

```bash
cd ~

echo "==> Install Ubuntu packages"
echo "==> When some packages went wrong, check http://mirrors.ustc.edu.cn/ubuntu/ for updating status."
bash /prepare/1-apt.sh | tee log-1-apt.txt

echo '==> Press master key (`Win` for Windows and right `Command` for Mac) and type `terminal` to start a GUI terminal'
echo '==> Or `Ctrl+Alt+T` to start a GUI terminal'
bash /prepare/2-unity.sh

echo '==> Return host machine and `vagrant reload && vagrant ssh`'
#exit

echo "==> Clone latest linuxbrew"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

if grep -q -i linuxbrew $HOME/.bashrc; then
    echo "==> .bashrc already contains linuxbrew"
else
    echo "==> Update .bashrc"

    echo >> $HOME/.bashrc
    echo '# Linuxbrew' >> $HOME/.bashrc
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >> $HOME/.bashrc
    echo "export MANPATH='$(brew --prefix)/share/man'":'"$MANPATH"' >> $HOME/.bashrc
    echo "export INFOPATH='$(brew --prefix)/share/info'":'"$INFOPATH"' >> $HOME/.bashrc
    echo "export HOMEBREW_NO_ANALYTICS=1" >> $HOME/.bashrc
    echo "export HOMEBREW_NO_AUTO_UPDATE=1" >> $HOME/.bashrc
    echo >> $HOME/.bashrc
fi

source $HOME/.bashrc

bash /prepare/3-brew.sh | tee log-3-brew.txt
source $HOME/.bashrc

bash -c "$(curl -fsSL https://raw.githubusercontent.com/wang-q/dotfiles/master/perl/install.sh)"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/wang-q/dotfiles/master/python/install.sh)"

bash /prepare/5-clone.sh
bash /prepare/6-download.sh

# Build jksrc.zip once and save binary files.
# Don't do this if jkbin-ubuntu-1404-2011.tar.gz exists.
### bash /prepare/extra/8-jksrc.sh

# linuxbrew's pkg-config conflicts with system wide $PKG_CONFIG_PATH, 
# and gcc from linuxbrew might introduce more troubles,
# so put them to the tail of job queues.
#bash /prepare/7-brew.sh | tee log-7-brew.txt
#source $HOME/.bashrc
#bash /prepare/8-node.sh

bash /prepare/extra/9-ensembl.sh    # Optional, needed by alignDB

#bash /prepare/9-pm2.sh

rm $HOME/log*.txt                   # review and delete all logs

bash /prepare/90-cleanup-user.sh    # Clean the vm
sudo bash /prepare/91-cleanup.sh         

#exit
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

# rm ~/Scripts/egavm/vm/egavm.ova
VBoxManage export egavm -o egavm.ova
```

## Box sizes

`du -hs ~/Scripts/egavm/vm/*`

| name         |  size  |
|:-------------|:------:|
| egavm.box    | 1.9 GB |
| egavm.ova    | 1.9 GB |
| mytrusty.box | 784 MB |

## VM rules

* The building VM's name is `egavm-build` and the user VM's is `egavm`.
* Java, Node.js, R and most of bioinformatics softwares (including blast+) are install by linuxbrew.
* Perl is managed by plenv, version 5.18.4.
* Dependant libs of Perl modules are installed by apt-get.
    * zlib
    * gsl
    * BerkeleyDB
    * GD
    * libxml2
    * gtk3
* Non-CPAN modules from github.
    * `cpanm --verbose https://github.com/wang-q/Task-EGA/archive/0.2.2.tar.gz`
    * `Task::EGA` is a module bundler.
* Mongodb are installed by apt-get in VM (by linuxbrew in standalone machine).
* Jim Kent's utils are installed to `~/bin`.
* Mysql and circos are installed to `~/share`.
* All ega related things are placed in `~/Scripts`.
