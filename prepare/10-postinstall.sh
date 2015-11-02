#!/usr/bin/env bash

echo "==> Copy .screenrc"
cp /prepare/resource/.screenrc $HOME
chmod -x $HOME/.screenrc

echo "==> Clean caches before release"
sudo apt-get clean
rm -fr $HOME/.cache/
rm -fr $HOME/.npm/
rm -fr $HOME/.node-gyp/
rm -fr $HOME/.cpan/
rm -fr $HOME/.cpanm/
rm -fr $HOME/.plenv/cache/

brew cleanup

# This is for Ubuntu:
# https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one
echo "==> Clean the disk drive"
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

echo "==> Clean the Bash history"
cat /dev/null > $HOME/.bash_history
