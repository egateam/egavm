#!/usr/bin/env bash

# kent userApps v308 generates much different result for maf* stuffs that looks very wrong. So don’t use it.
cd /prepare/resource/
unzip jksrc.zip # download in 2011
cd kent/src

sed -i 's/CC\=gcc/CC\=gcc \-Wno\-error\=unused\-but\-set\-variable /' inc/common.mk

export MACHTYPE=x86_64
export MYSQLLIBS="-L/home/vagrant/.linuxbrew/opt/mysql51/lib/mysql -lmysqlclient -lz"
export MYSQLINC="/home/vagrant/.linuxbrew/opt/mysql51/include/mysql"
make

cd $HOME/bin
tar cvfz jkbin-ubuntu-1404-2011.tar.gz x86_64
mv jkbin-ubuntu-1404-2011.tar.gz /prepare/resource/
