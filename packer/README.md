# Instructions for get a Ubuntu base box

## Build it myself

I'm tired of guessing parameters of other people's box. So just copy & paste codes from [this repo](https://github.com/shiguredo/packer-templates/tree/develop/ubuntu-14.04)
to get my own packer template.

```bash
cd ~/Scripts/egavm/packer
bash packer.sh
```

## Other boxes

* Official box
    * `vagrant box add ubuntu/trusty64 --provider virtualbox --box-version 20151020.0.0 --force`
    * `vagrant box add https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box --name mytrusty --force`
* boxcutter's box
    * `git clone https://github.com/boxcutter/ubuntu`
    * `vagrant box add box-cutter/ubuntu1404-desktop --provider virtualbox --box-version 2.0.5`
