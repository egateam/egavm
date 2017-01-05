#!/usr/bin/env bash

DOWNLOADDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# ubuntu
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-server-amd64.iso
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-desktop-amd64.iso

# virtualbox
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.12/VirtualBox-5.1.12-112440-OSX.dmg
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.12/VirtualBox-5.1.12-112440-Win.exe
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.12/Oracle_VM_VirtualBox_Extension_Pack-5.1.12-112440.vbox-extpack

# virtualbox additions
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.12/VBoxGuestAdditions_5.1.12.iso

# perl
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/CPAN/authors/id/R/RJ/RJBS/perl-5.18.4.tar.bz2
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/CPAN/authors/id/R/RJ/RJBS/perl-5.18.4.tar.gz

# 6-download.sh
wget -N -P ${DOWNLOADDIR} http://ftp.ncbi.nlm.nih.gov/blast/executables/legacy/2.2.26/blast-2.2.26-universal-macosx.tar.gz
wget -N -P ${DOWNLOADDIR} http://ftp.ncbi.nlm.nih.gov/blast/executables/legacy/2.2.26/blast-2.2.26-x64-linux.tar.gz

# 7-brew.sh bioinformatics tools
wget -N -P ${DOWNLOADDIR} ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.5.0/ncbi-blast-2.5.0+-src.tar.gz
wget -N -P ${DOWNLOADDIR} ftp://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/LATEST/ncbi-rmblastn-2.2.28-x64-linux.tar.gz
wget -N -P ${DOWNLOADDIR} mirrors.ustc.edu.cn/CRAN/src/base/R-3/R-3.3.2.tar.gz

if [ ! -e ${DOWNLOADDIR}/RepeatMasker-open-4-0-5.tar.gz ];
then
    wget -N -P ${DOWNLOADDIR} http://www.repeatmasker.org/RepeatMasker-open-4-0-5.tar.gz
fi

# extra/7-mysql.sh
wget -N -P ${DOWNLOADDIR} http://mysql.mirrors.pair.com/Downloads/MySQL-5.1/mysql-5.1.73.tar.gz
