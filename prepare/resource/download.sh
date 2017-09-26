#!/usr/bin/env bash

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# ubuntu
if [ ! -e ${BASE_DIR}/ubuntu-14.04.5-*.iso ];
then
    wget -N -P ${BASE_DIR} http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-server-amd64.iso
#    wget -N -P ${BASE_DIR} http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-desktop-amd64.iso
fi

# virtualbox
wget -N -P ${BASE_DIR} http://download.virtualbox.org/virtualbox/5.1.26/VirtualBox-5.1.26-117224-OSX.dmg
wget -N -P ${BASE_DIR} http://download.virtualbox.org/virtualbox/5.1.26/VirtualBox-5.1.26-117224-Win.exe

wget -N -P ${BASE_DIR} http://download.virtualbox.org/virtualbox/5.1.26/Oracle_VM_VirtualBox_Extension_Pack-5.1.26-117224.vbox-extpack

# virtualbox additions
wget -N -P ${BASE_DIR} http://download.virtualbox.org/virtualbox/5.1.26/VBoxGuestAdditions_5.1.26.iso

# perl
wget -N -P ${BASE_DIR} http://mirrors.ustc.edu.cn/CPAN/authors/id/R/RJ/RJBS/perl-5.18.4.tar.bz2
wget -N -P ${BASE_DIR} http://mirrors.ustc.edu.cn/CPAN/authors/id/R/RJ/RJBS/perl-5.18.4.tar.gz

# 7-brew.sh bioinformatics tools
wget -N -P ${BASE_DIR} ftp://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/LATEST/ncbi-rmblastn-2.2.28-x64-linux.tar.gz

if [ ! -e ${BASE_DIR}/RepeatMasker-open-4-0-7.tar.gz ];
then
    wget -N -P ${BASE_DIR} http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz
fi

# extra/7-mysql.sh
wget -N -P ${BASE_DIR} http://mysql.mirrors.pair.com/Downloads/MySQL-5.1/mysql-5.1.73.tar.gz
