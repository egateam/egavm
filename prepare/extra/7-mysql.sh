#!/usr/bin/env bash

mkdir -p $HOME/share/

echo "==> compile mysql"
cd $HOME/share/
rm -fr mysql-*
tar xvfz /prepare/resource/mysql-5.1.73.tar.gz
cd mysql-*

export MYSQL_USER=`whoami`
export MYSQL_DIR=$HOME/share/mysql

if [[ `uname` == 'Darwin' ]];
then
    export CC=gcc-5
    export CXX=gcc-5
else
    export CC=gcc
    export CXX=gcc
fi

CFLAGS="-O3" CXXFLAGS="-O3 -felide-constructors -fno-exceptions -fno-rtti" \
    ./configure \
    --prefix=${MYSQL_DIR} \
    --with-extra-charsets=complex \
    --enable-thread-safe-client \
    --enable-local-infile \
    --enable-shared \
    --enable-assembler \
    --without-docs \
    --without-man \
    --without-debug \
    --with-plugins=myisam \
    --disable-dependency-tracking \
    --with-mysqld-user=${MYSQL_USER} \
    --localstatedir=${MYSQL_DIR}/data \
    --sysconfdir=${MYSQL_DIR} \
    --with-unix-socket-path=${MYSQL_DIR}/mysql.sock

make -j 8
make install

mkdir -p ${MYSQL_DIR}/data

if grep -q -i mysqlbin $HOME/.bashrc; then
    echo "==> .bashrc already contains mysqlbin"
else
    echo "==> Update .bashrc"

    LB_PATH='export PATH="$HOME/share/mysql/bin:$PATH"'
    echo '# mysqlbin' >> $HOME/.bashrc
    echo $LB_PATH >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $LB_PATH
fi

cat <<EOF > ${MYSQL_DIR}/my.cnf
[mysqld]
user=${MYSQL_USER}
basedir=${MYSQL_DIR}
datadir=${MYSQL_DIR}/data
port=3306
socket=${MYSQL_DIR}/mysql.sock

loose-skip-innodb
skip-external-locking

character-set-server=latin1
default-storage-engine = MyISAM

key_buffer_size = 4096M
max_allowed_packet = 16M
table_open_cache = 512
sort_buffer_size = 16M
read_buffer_size = 16M
read_rnd_buffer_size = 32M
myisam_sort_buffer_size = 128M
thread_cache_size = 16
thread_concurrency = 32
query_cache_size = 128M
query_cache_limit = 8M

[mysqld_safe]
log-error=${MYSQL_DIR}/mysqld.log
pid-file=${MYSQL_DIR}/mysqld.pid
socket=${MYSQL_DIR}/mysql.sock

[client]
port=3306
user=${MYSQL_USER}
socket=${MYSQL_DIR}/mysql.sock

[mysqladmin]
user=root
port=3306
socket=${MYSQL_DIR}/mysql.sock

[mysql]
port=3306
socket=${MYSQL_DIR}/mysql.sock

[mysql_install_db]
user=${MYSQL_USER}
port=3306
basedir=${MYSQL_DIR}
datadir=${MYSQL_DIR}/data
socket=${MYSQL_DIR}/mysql.sock

[myisamchk]
key_buffer_size = 256M
sort_buffer_size = 256M
read_buffer = 16M
write_buffer = 16M

EOF

echo "==> Fill mysql system tables"
unset TMPDIR
unset MYSQL_USER
unset MYSQL_DIR

mysql_install_db

echo "==> Start mysql service"
cd $HOME/share/mysql
$HOME/share/mysql/bin/mysqld_safe &
sleep 5

echo "==> Securing mysql service"
mysql_secure_installation

# perl Makefile.PL --testuser alignDB --testpassword alignDB
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest DBD::mysql

rm -fr $HOME/share/mysql-*

if [[ `uname` == 'Darwin' ]];
then
cat <<EOF > $HOME/Library/LaunchAgents/org.mysql.mysqld.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>KeepAlive</key>
  <true/>
  <key>Label</key>
  <string>org.mysql.mysqld</string>
  <key>Program</key>
  <string>$HOME/share/mysql/bin/mysqld_safe</string>
  <key>RunAtLoad</key>
  <true/>
  <key>WorkingDirectory</key>
  <string>$HOME/share/mysql</string>
  <key>StandardErrorPath</key>
  <string>$HOME/share/mysql/output.log</string>
  <key>StandardOutPath</key>
  <string>$HOME/share/mysql/output.log</string>
</dict>
</plist>
EOF
fi

# create mysql user
cat <<EOF

# copy & paste the following lines to command prompt; then type password of mysql root

source $HOME/.bashrc
mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'alignDB'@'%' IDENTIFIED BY 'alignDB'"

# start mysql on logon

launchctl load ~/Library/LaunchAgents/org.mysql.mysqld.plist

EOF
