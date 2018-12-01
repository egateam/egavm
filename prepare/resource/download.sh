#!/usr/bin/env bash

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# ubuntu
if [[ ! -e ${BASE_DIR}/ubuntu-14.04.5-server&&md64.iso ]]; then
    wget -N -P ${BASE_DIR} https://mirrors.nju.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-server-amd64.iso
    wget -N -P ${BASE_DIR} https://mirrors.nju.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-desktop-amd64.iso
fi

# virtualbox
wget -N -P ${BASE_DIR} https://mirrors.tuna.tsinghua.edu.cn/virtualbox/5.2.22/VirtualBox-5.2.22-126460-OSX.dmg
wget -N -P ${BASE_DIR} https://mirrors.tuna.tsinghua.edu.cn/virtualbox/5.2.22/VirtualBox-5.2.22-126460-Win.exe

wget -N -P ${BASE_DIR} https://mirrors.tuna.tsinghua.edu.cn/virtualbox/5.2.22/Oracle_VM_VirtualBox_Extension_Pack-5.2.22.vbox-extpack

# virtualbox additions
wget -N -P ${BASE_DIR} https://mirrors.tuna.tsinghua.edu.cn/virtualbox/5.2.22/VBoxGuestAdditions_5.2.22.iso

# large bottles
wget -N -P ${BASE_DIR} https://linuxbrew.bintray.com/bottles/jdk-9.0.1+11.x86_64_linux.bottle.tar.gz
wget -N -P ${BASE_DIR} https://linuxbrew.bintray.com/bottles/blast-2.7.1.x86_64_linux.bottle.tar.gz
wget -N -P ${BASE_DIR} https://linuxbrew.bintray.com/bottles/r-3.4.4.x86_64_linux.bottle.tar.gz
wget -N -P ${BASE_DIR} https://linuxbrew.bintray.com/bottles/mysql-5.7.21.x86_64_linux.bottle.tar.gz

# bioinformatics tools
wget -N -P ${BASE_DIR} ftp://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/LATEST/ncbi-rmblastn-2.2.28-x64-linux.tar.gz

if [[ ! -e ${BASE_DIR}/RepeatMasker-open-4-0-7.tar.gz ]]; then
    wget -N -P ${BASE_DIR} http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz
fi

if [[ ! -e ${BASE_DIR}/repeatmaskerlibraries-20140131.tar.gz ]]; then
    wget -N -P ${BASE_DIR} https://github.com/egateam/egavm/releases/download/20170907/repeatmaskerlibraries-20140131.tar.gz
fi

if [[ ! -e ${BASE_DIR}/jkbin-darwin-2011.tar.gz ]]; then
    wget -N -P ${BASE_DIR} https://github.com/egateam/egavm/releases/download/20170907/jkbin-darwin-2011.tar.gz
fi

if [[ ! -e ${BASE_DIR}/jkbin-ubuntu-1404-2011.tar.gz ]]; then
    wget -N -P ${BASE_DIR} https://github.com/egateam/egavm/releases/download/20170907/jkbin-ubuntu-1404-2011.tar.gz
fi

# extra/7-mysql.sh
wget -N -P ${BASE_DIR} http://mysql.mirrors.pair.com/Downloads/MySQL-5.1/mysql-5.1.73.tar.gz
