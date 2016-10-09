#!/bin/bash -eux

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

echo "==> Cleaning up tmp"
sudo rm -rf /tmp/*

echo "==> Cleaning apt cache"
sudo apt-get -y autoremove --purge
sudo apt-get -y clean
sudo apt-get -y autoclean

echo "==> Clean caches before release"
rm -fr $HOME/.cache/
rm -fr $HOME/.npm/
rm -fr $HOME/.node-gyp/
rm -fr $HOME/.cpan/
rm -fr $HOME/.cpanm/
rm -fr $HOME/.plenv/cache/

brew cleanup

echo "==> Clean the Bash history"
cat /dev/null > $HOME/.bash_history

# Clean up log files
find /var/log -type f \
    | while read f;
    do
        sudo echo -ne '' > "${f}";
    done;

# This is for Ubuntu:
# https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one
echo "==> Zero disk"
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
rm -f /EMPTY

# Make sure we wait until all the data is written to disk, otherwise
# Packer might quite too early before the large files are deleted
sync

echo "==> Disk usage before cleanup"
echo "${DISK_USAGE_BEFORE_CLEANUP}"

echo "==> Disk usage after cleanup"
df -h
