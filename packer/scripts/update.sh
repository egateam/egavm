#!/usr/bin/env bash

echo "==> Switch to the USTC mirror"

# https://lug.ustc.edu.cn/wiki/mirrors/help/ubuntu
cat <<EOF > list.tmp
# USTC MIRRORS
deb https://mirrors.ustc.edu.cn/ubuntu/ trusty main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ trusty main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ trusty-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ trusty-security main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse

## Not recommended
# deb https://mirrors.ustc.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse

EOF

if [ ! -e /etc/apt/sources.list.bak ];
then
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
fi
mv list.tmp /etc/apt/sources.list

echo "==> Disabling the release upgrader"
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "==> Updating list of repositories"
apt-get -y update

echo "==> Performing dist-upgrade (all packages and kernel)"
apt-get -y dist-upgrade --force-yes

echo "==> Restore original sources.list"
if [ -e /etc/apt/sources.list.bak ];
then
    rm /etc/apt/sources.list
    mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi

reboot
sleep 60
