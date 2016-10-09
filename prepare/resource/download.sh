#!/usr/bin/env bash

DOWNLOADDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# ubuntu
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-server-amd64.iso
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/ubuntu-releases/14.04.5/ubuntu-14.04.5-desktop-amd64.iso

# virtualbox
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.6/VirtualBox-5.1.6-110634-OSX.dmg
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.6/VirtualBox-5.1.6-110634-Win.exe
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.6/Oracle_VM_VirtualBox_Extension_Pack-5.1.6-110634.vbox-extpack

# virtualbox additions
wget -N -P ${DOWNLOADDIR} http://download.virtualbox.org/virtualbox/5.1.6/VBoxGuestAdditions_5.1.6.iso

# perl
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/CPAN/authors/id/R/RJ/RJBS/perl-5.18.4.tar.bz2
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/CPAN/authors/id/R/RJ/RJBS/perl-5.18.4.tar.gz

# 6-download.sh
wget -N -P ${DOWNLOADDIR} http://ftp.ncbi.nlm.nih.gov/blast/executables/legacy/2.2.26/blast-2.2.26-universal-macosx.tar.gz
wget -N -P ${DOWNLOADDIR} http://ftp.ncbi.nlm.nih.gov/blast/executables/legacy/2.2.26/blast-2.2.26-x64-linux.tar.gz

# 7-brew.sh libs
wget -N -P ${DOWNLOADDIR} http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.1.tar.gz
wget -N -P ${DOWNLOADDIR} https://fossies.org/linux/misc/xz-5.2.1.tar.gz
wget -N -P ${DOWNLOADDIR} http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
wget -N -P ${DOWNLOADDIR} http://www.ijg.org/files/jpegsrc.v8d.tar.gz
wget -N -P ${DOWNLOADDIR} http://221.204.176.53/openssl-1.0.2c.tar.gz
wget -N -P ${DOWNLOADDIR} http://mirrors.ustc.edu.cn/gnu/readline/readline-6.3.tar.gz

# 7-brew.sh bioinformatics tools
wget -N -P ${DOWNLOADDIR} ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.4.0/ncbi-blast-2.4.0+-src.tar.gz
wget -N -P ${DOWNLOADDIR} ftp://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/LATEST/ncbi-rmblastn-2.2.28-x64-linux.tar.gz
wget -N -P ${DOWNLOADDIR} http://www.clustal.org/download/2.1/clustalw-2.1.tar.gz
wget -N -P ${DOWNLOADDIR} http://selab.janelia.org/software/hmmer3/3.1b2/hmmer-3.1b2.tar.gz
wget -N -P ${DOWNLOADDIR} http://www.bx.psu.edu/miller_lab/dist/lastz-1.02.00.tar.gz
wget -N -P ${DOWNLOADDIR} http://mafft.cbrc.jp/alignment/software/mafft-7.221-with-extensions-src.tgz
wget -N -P ${DOWNLOADDIR} https://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2
wget -N -P ${DOWNLOADDIR} https://github.com/stamatak/standard-RAxML/archive/v8.1.15.tar.gz
wget -N -P ${DOWNLOADDIR} http://www.repeatmasker.org/RepeatMasker-open-4-0-5.tar.gz

# extra/7-mysql.sh
wget -N -P ${DOWNLOADDIR} http://mysql.mirrors.pair.com/Downloads/MySQL-5.1/mysql-5.1.73.tar.gz

# 8-node.sh
wget -N -P ${DOWNLOADDIR} https://nodejs.org/dist/v0.12.12/node-v0.12.13.tar.gz
wget -N -P ${DOWNLOADDIR} https://registry.npmjs.org/npm/-/npm-2.15.1.tgz
