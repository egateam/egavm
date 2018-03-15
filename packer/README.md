# Instructions for getting an Ubuntu base box

## Build it myself

I'm tired of guessing parameters of other people's boxes. So just copy & paste codes from other
repos to get my own packer template.

When internet connection is OK, the building process costs about less than 30 minutes.

```bash
# rm ~/Scripts/egavm/vm/mytrusty.box

#real	25m14.287s
#user	0m36.443s
#sys	0m15.740s
time bash ~/Scripts/egavm/packer/packer.sh
```

Rules:

* Keep it as simple as possible in `http/preseed.cfg`.
* `apt-get` from nearby mirrors.
* Upgrade kernel.
* Install Ubuntu desktop without recommends.
* VirtualBox only. For other platform, just use boxcutter's atlas boxes.
* Install VirtualBox guest additions in building phase.
* `vagrant:vagrant` as username:password.
* Leave DVD there. Remove it by vagrant later.

## Checksum

For `template.json`.

```bash
openssl md5 ~/Scripts/egavm/prepare/resource/ubuntu-14.04.5-server-amd64.iso
openssl sha256 ~/Scripts/egavm/prepare/resource/VBoxGuestAdditions_5.2.8.iso
```

## Other boxes

* Official box
    * `vagrant box add ubuntu/trusty64 --provider virtualbox --box-version 20151020.0.0 --force`
    * `vagrant box add
      https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
      --name mytrusty --force`

This build is a mixture of the following builds.

* boxcutter
    * `git clone https://github.com/boxcutter/ubuntu`
    * `vagrant box add box-cutter/ubuntu1404-desktop --provider virtualbox --box-version 2.0.5`
* shiguredo
    * https://github.com/shiguredo/packer-templates/tree/develop/ubuntu-14.04
