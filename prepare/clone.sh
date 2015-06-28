#!/usr/bin/env bash

cd ~

# make sure ~/bin in your $PATH
mkdir -p bin

# custom dependance
git clone https://github.com/wang-q/faops.git
cd faops && make && cp faops ~/bin/

# all parts of ega
cd ~

git clone https://github.com/wang-q/ega.git

git clone https://github.com/wang-q/egaz.git

git clone https://github.com/wang-q/egas.git

git clone https://github.com/wang-q/alignDB.git

git clone https://github.com/wang-q/withncbi.git

# node stuffs
cd ~/ega

npm --verbose install
bower --verbose install

mkdir -p ~/ega/upload
