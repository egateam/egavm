#!/usr/bin/env bash

# config repeatmasker
cd $HOME/.linuxbrew/Cellar/repeatmasker/4.0.5/libexec
tar zxvf /prepare/resource/repeatmaskerlibraries-20140131.tar.gz
sed -i 's/\/usr\/bin\/perl/env/' config.txt
./configure < config.txt

rm $HOME/.linuxbrew/bin/rmOutToGFF3.pl
sed -i 's/::Bin/::RealBin/' $HOME/.linuxbrew//Cellar/repeatmasker/4.0.5/libexec/util/rmOutToGFF3.pl
ln -s $HOME/.linuxbrew//Cellar/repeatmasker/4.0.5/libexec/util/rmOutToGFF3.pl $HOME/.linuxbrew/bin/rmOutToGFF3.pl

# config withncbi
sed -i 's/\~\/Scripts/\~/' $HOME/withncbi/config.ini

# .screenrc
cp /prepare/resource/.screenrc $HOME

# jvarkit
mkdir -p $HOME/share/jvarkit
cp /prepare/resource/biostar94573.jar $HOME/share/jvarkit

# clean cache before release
sudo apt-get clean
brew cleanup
rm -fr $HOME/.cache/
rm -fr $HOME/.npm/
rm -fr $HOME/.node-gyp/
rm -fr $HOME/.cpan/
rm -fr $HOME/.cpanm/
rm -fr $HOME/.plenv/cache/

rm -fr /prepare/resource/kent

# Clean the drive (this is for Ubuntu):
# https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

# clear the Bash History
cat /dev/null > ~/.bash_history && history -c
