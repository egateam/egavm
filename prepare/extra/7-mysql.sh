#!/usr/bin/env bash

mkdir -p $HOME/share/

echo "==> compile mysql"
cd $HOME/share/
tar xvfz /prepare/resource/mysql-5.1.73.tar.gz

cd mysql-*

export MYSQL_USER=`whoami`
export MYSQL_DIR=$HOME/share/mysql

CFLAGS="-O3" CXX=gcc CXXFLAGS="-O3 -felide-constructors -fno-exceptions -fno-rtti" \
    ./configure \
    --enable-assembler \
    --without-bench \
    --without-docs \
    --without-man \
    --without-debug \
    --with-plugins=myisam \
    --enable-thread-safe-client \
    --enable-local-infile \
    --enable-shared \
    --with-partition \
    --with-extra-charsets=complex \
    --disable-dependency-tracking \
    --with-mysqld-user=${MYSQL_USER} \
    --prefix=${MYSQL_DIR} \
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
user=wangq
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

[client]
port=3306
user=wangq
socket=${MYSQL_DIR}/mysql.sock

[mysqladmin]
user=root
port=3306
socket=${MYSQL_DIR}/mysql.sock

[mysql]
port=3306
socket=${MYSQL_DIR}/mysql.sock

[mysql_install_db]
user=wangq
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

# copy & paste to command line; then type password of mysql root
# mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'alignDB'@'%' IDENTIFIED BY 'alignDB'"

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest DBD::mysql
