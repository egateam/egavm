#!/usr/bin/env bash

BASE_DIR=/home/vagrant/Scripts
mkdir -p $BASE_DIR
cd $BASE_DIR

# all parts of ega
for OP in faops egaz egas alignDB withncbi
do
    if [ ! -d $BASE_DIR/$OP/.git ]
    then
        echo "==> Clone $OP"
        git clone https://github.com/wang-q/$OP.git $BASE_DIR/$OP
    else
        echo "==> Pull $OP"
        cd $BASE_DIR/$OP
        git pull
    fi
done

# make sure ~/bin in your $PATH
if grep -q -i homebin ~/.bashrc; then
    echo "==> .bashrc already contains homebin"
else
    echo "==> Update .bashrc"

    HOME_PATH='export PATH="$HOME/bin:$PATH"'
    echo '# Homebin' >> ~/.bashrc
    echo $HOME_PATH >> ~/.bashrc
    echo >> ~/.bashrc

    eval $HOME_PATH
fi
mkdir -p ~/bin
cd $BASE_DIR/faops && make && cp faops ~/bin

# ega/upload may be created by vagrant
echo "==> Clone ega"
mkdir -p $BASE_DIR/ega
sudo chown vagrant:vagrant $BASE_DIR/ega -R
cd $BASE_DIR/ega
git clone https://github.com/wang-q/ega.git tmp && mv tmp/.git . && rm -rf tmp && git reset --hard
cp settings.js.example settings.js
