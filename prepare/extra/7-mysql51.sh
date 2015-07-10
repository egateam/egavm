#!/usr/bin/env bash

rm ~/.cache/Homebrew/*.incomplete
cp /prepare/resource/mysql-5.1.73.tar.gz    ~/.cache/Homebrew/mysql51-5.1.73.tar.gz
cp /prepare/resource/openssl-1.0.2c.tar.gz  ~/.cache/Homebrew/openssl-1.0.2c.tar.gz

brew tap homebrew/versions
brew install mysql51

if grep -q -i mysqlbin ~/.bashrc; then
    echo "==> .bashrc already contains mysqlbin"
else
    echo "==> Update .bashrc"

    LB_PATH='export PATH="$HOME/.linuxbrew/Cellar/mysql51/5.1.73_1/bin:$PATH"'
    echo '# mysqlbin' >> ~/.bashrc
    echo $LB_PATH >> ~/.bashrc
    echo >> ~/.bashrc

    eval $LB_PATH
fi

echo "==> Fill mysql system tables"
unset TMPDIR
mysql_install_db

echo "==> Start mysql service"
cd /home/vagrant/.linuxbrew/Cellar/mysql51/5.1.73_1
/home/vagrant/.linuxbrew/Cellar/mysql51/5.1.73_1/bin/mysqld_safe &
sleep 5

echo "==> Securing mysql service"
mysql_secure_installation

# There is no my.cnf by default.
# http://stackoverflow.com/questions/7973927/for-homebrew-mysql-installs-wheres-my-cnf

# copy & paste to command line; then type password of mysql root
# mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'alignDB'@'%' IDENTIFIED BY 'alignDB'"

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest DBD::mysql
