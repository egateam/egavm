# Instructions for building scripts

## Software versions

* Ubuntu:       14.04.3
* Vagrant:      1.7.4
* VirtualBox:   5.0.4

## Get public vagrant boxes for Ubuntu 14.04.3

    ```bash
    vagrant box add box-cutter/ubuntu1404-desktop --provider virtualbox --box-version 2.0.3
    vagrant box add box-cutter/ubuntu1404 --provider virtualbox --box-version 2.0.3
    ```

## Build a vagrant box from .iso.

See [packer.sh](prepare/packer.sh)

##  Vagrantfiles for setting up basic VM.

* `prepare/virtualbox/`
* `prepare/virtualbox-headless/`

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
    sh /prepare/1-apt.sh | tee log-1-apt.txt

    ## Press master button (Win for Windows and right Command for Mac) and type `terminal` to start a GUI terminal
    ## sh /prepare/2-unity.sh

    sh /prepare/3-plenv.sh
    source $HOME/.bashrc
    sh /prepare/4-cpanm.sh | tee log-4-cpanm.txt

    sh /prepare/5-clone.sh
    sh /prepare/6-download.sh

    sh /prepare/extra/4-cpanm.sh    # Optional, needed by alignDB

    # linuxbrew's pkg-config will conflict system wide $PKG_CONFIG_PATH, so put them to the tail of job queues.
    sh /prepare/7-brew.sh | tee log-7-brew.txt
    source $HOME/.bashrc
    sh /prepare/8-node.sh

    sh /prepare/extra/7-mysql.sh           # Optional, compiling full mysql51.
    # sh /prepare/extra/7-mysql-client.sh  # Optional, Linuxbrew mysql51 client, needed by alignDB and building jksrc.
    source $HOME/.bashrc                   # After installation, add user alignDB to mysql.

    # Build jksrc.zip once and save binary files.
    # Don't do this if jkbin-ubuntu-1404-2011.tar.gz exists.
    ### sh /prepare/extra/8-jksrc.sh

    sh /prepare/extra/9-ensembl.sh  # Optional, needed by alignDB

    sh /prepare/9-postinstall.sh    # Clean the System
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

## Box sizes

| name               | size    |
| :-----             | :-----: |
| egavm.box          | 2.1 GB  |
| egavm-headless.box | 1.4 GB  |
