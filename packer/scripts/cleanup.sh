#!/bin/bash -eux

echo "==> Cleaning up dhcp leases"
if [ -d "/var/lib/dhcp" ]; then
    rm /var/lib/dhcp/*
fi

echo "==> Cleaning up udev rules"
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

# Add delay to prevent "vagrant reload" from failing
echo "pre-up sleep 2" >> /etc/network/interfaces

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

echo "==> Cleaning up tmp"
rm -rf /tmp/*

# Cleanup apt cache
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

# Remove Bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# Clean up log files
find /var/log -type f | while read f; do echo -ne '' > "${f}"; done;

echo "==> Whiteout root"
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
count=$((count - 1))
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace

echo "==> Whiteout /boot"
count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
count=$((count - 1))
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count
rm /boot/whitespace

echo "==> Clear out swap and disable until reboot"
set +e
swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
case "$?" in
    2|0) ;;
    *) exit 1 ;;
esac
set -e
if [ "x${swapuuid}" != "x" ]; then
    # Whiteout the swap partition to reduce box size
    # Swap is disabled till reboot
    swappart=$(readlink -f /dev/disk/by-uuid/$swapuuid)
    /sbin/swapoff "${swappart}"
    dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
    /sbin/mkswap -U "${swapuuid}" "${swappart}"
fi

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
