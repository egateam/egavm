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
#        --with-mysqld-user=vagrant \
#        --with-unix-socket-path=$HOME/share/mysql/tmp/mysql.sock \
#        --without-docs \
#        --without-debug \
#        --disable-dependency-tracking \
#        --localstatedir=$HOME/share/mysql/data \
#        --enable-thread-safe-client \
#        --enable-local-infile
#
#mkdir -p $HOME/share/mysql/log

#sudo mv /etc/mysql/my.cnf /etc/mysql/my.cnf.back

# rm ~/.cache/Homebrew/mysql51-5.1.73.tar.gz.incomplete
# cp /prepare/resource/mysql-5.1.73.tar.gz ~/.cache/Homebrew/mysql51-5.1.73.tar.gz

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

echo " + Fill mysql system tables"
unset TMPDIR
mysql_install_db

echo " + Start mysql service"
cd /home/vagrant/.linuxbrew/Cellar/mysql51/5.1.73_1
/home/vagrant/.linuxbrew/Cellar/mysql51/5.1.73_1/bin/mysqld_safe &
sleep 5

echo " + Securing mysql service"
mysql_secure_installation

# copy & paste to command line; then type password of mysql root
# mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'alignDB'@'%' IDENTIFIED BY 'alignDB'"
