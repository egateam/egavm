#!/usr/bin/env bash

mkdir -p $HOME/share/

echo "====> Install MongoDB <===="

echo "==> download"
cd /prepare/resource/
wget -N https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1404-3.0.7.tgz

echo "==> untar"
cd $HOME/share/
tar xvfz /prepare/resource/mongodb-linux-x86_64-ubuntu1404*.tgz

mkdir -p $HOME/share/mongodb
cp -R -n mongodb-linux-x86_64-*/ mongodb

mkdir -p $HOME/share/mongodb/log
mkdir -p $HOME/share/mongodb/data

echo "==> cnf file"
cd $HOME/share/mongodb
cat <<EOF > mongod.cnf
systemLog:
    destination: file
    path: /home/wangq/share/mongodb/log/mongod.log
    logAppend: true
storage:
    dbPath: /home/wangq/share/mongodb/data
    directoryPerDB: true
    engine: wiredTiger
    journal:
        enabled: false
net:
    bindIp: 127.0.0.1
    port: 27017
    http:
        enabled: true
        RESTInterfaceEnabled: true

EOF

echo "==> done"

cat <<EOF

# Start mongodb by running

numactl --interleave=all ~/share/mongodb/bin/mongod --config ~/share/mongodb/mongod.cnf

EOF
