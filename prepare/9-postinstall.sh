#!/usr/bin/env bash

echo "==> Config repeatmasker"
cd `brew --prefix`/Cellar/repeatmasker/4.0.5/libexec
tar zxvf /prepare/resource/repeatmaskerlibraries-20140131.tar.gz
if [[ `uname` == 'Darwin' ]];
then
    sed -i".bak" 's/\/usr\/bin\/perl/env/' config.txt
else
    sed -i 's/\/usr\/bin\/perl/env/' config.txt
fi
./configure < config.txt

rm `brew --prefix`/bin/rmOutToGFF3.pl
if [[ `uname` == 'Darwin' ]];
then
    sed -i".bak" 's/::Bin/::RealBin/' `brew --prefix`/Cellar/repeatmasker/4.0.5/libexec/util/rmOutToGFF3.pl
else
    sed -i 's/::Bin/::RealBin/' `brew --prefix`/Cellar/repeatmasker/4.0.5/libexec/util/rmOutToGFF3.pl
fi
ln -s `brew --prefix`/Cellar/repeatmasker/4.0.5/libexec/util/rmOutToGFF3.pl `brew --prefix`/bin/rmOutToGFF3.pl

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
