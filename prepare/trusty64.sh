#!/usr/bin/env bash

cd /prepare/resource/

echo "==> Get official Ubuntu box"

wget -N https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
vagrant box add trusty-server-cloudimg-amd64-vagrant-disk1.box --name mytrusty --force

#vagrant box add ubuntu/trusty64 --box-version 20150609.0.9 --provider virtualbox --box-version 20151020.0.0 --force
