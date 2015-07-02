#!/usr/bin/env bash

#cd /prepare/resource/
#curl http://cdn.mysql.com/Downloads/MySQL-5.1/mysql-5.1.73.tar.gz -O
#cd $HOME/share/
#tar xvfz /prepare/resource/mysql-5.1.73.tar.gz
#cd mysql-*
#
## mysql 5.1
#CFLAGS="-O3" CXX=gcc CXXFLAGS="-O3 -felide-constructors -fno-exceptions -fno-rtti" ; \
#    ./configure \
#        --prefix=$HOME/share/mysql \
#        --without-readline \
#        --enable-assembler \
#        --with-plugins=myisam \
#        --with-mysqld-ldflags=-all-static \
#        --with-client-ldflags=-all-static \
#        --with-mysqld-user=vagrant \
#        --with-unix-socket-path=$HOME/share/mysql/tmp/mysql.sock \
#        --without-docs \
#        --without-debug \
#        --disable-dependency-tracking \
#        --localstatedir=$HOME/share/mysql/data \
#        --enable-thread-safe-client \
#        --enable-local-infile
#
#
#
#mkdir -p $HOME/share/mysql/log

brew tap homebrew/versions
brew install mysql51


if grep -q -i mysqlbin ~/.bashrc; then
    echo " + .bashrc already contains mysqlbin"
else
    echo " + Update .bashrc"

    LB_PATH='export PATH="$HOME/.linuxbrew/Cellar/mysql51/5.1.73_1/bin:$PATH"'
    echo '# mysqlbin' >> ~/.bashrc
    echo $LB_PATH >> ~/.bashrc
    echo >> ~/.bashrc

    eval $LB_PATH
fi

unset TMPDIR
mysql_install_db
mysqld_safe &
mysql_secure_installation

# copy & paste to command line; then type password of mysql root
# mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'alignDB'@'%' IDENTIFIED BY 'alignDB'"
