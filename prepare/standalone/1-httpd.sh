#!/usr/bin/env bash

mkdir -p $HOME/share/

echo "==> httpd"

# download
cd /prepare/resource/
wget -N http://mirrors.ustc.edu.cn/apache/httpd/httpd-2.4.16.tar.gz
wget -N http://mirrors.ustc.edu.cn/apache/apr/apr-1.5.2.tar.gz
wget -N http://mirrors.ustc.edu.cn/apache/apr/apr-util-1.5.4.tar.gz

# untar
cd $HOME/share/
tar xvfz /prepare/resource/httpd-2.*.tar.gz
tar xvfz /prepare/resource/apr-1.*.tar.gz
tar xvfz /prepare/resource/apr-util-1.*.tar.gz

mv apr-1* apr
mv apr-util-1* apr-util
mv apr httpd-2.*/srclib/
mv apr-util httpd-2.*/srclib/

# compiling
cd $HOME/share/httpd-2.*
./configure \
    --enable-file-cache \
    --enable-cache \
    --enable-disk-cache \
    --enable-mem-cache \
    --enable-deflate \
    --enable-expires \
    --enable-headers \
    --enable-usertrack \
    --enable-cgi \
    --enable-vhost-alias \
    --enable-rewrite \
    --enable-so \
    --with-included-apr \
    --prefix=${HOME}/share/httpd
make -j 4
make install

# Modify httpd.conf
cd $HOME/share/httpd
if [ ! -e conf/httpd.conf.bak ]
then
    cp conf/httpd.conf conf/httpd.conf.bak
fi
sed -i 's/Listen 80$/Listen 8080/' conf/httpd.conf
sed -i 's/#LoadModule cgid_module/LoadModule cgid_module/' conf/httpd.conf
sed -i 's/#LoadModule cgi_module/LoadModule cgi_module/' conf/httpd.conf
sed -i 's/#AddHandler cgi-script/AddHandler cgi-script/' conf/httpd.conf
