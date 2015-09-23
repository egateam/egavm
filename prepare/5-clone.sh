#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts
mkdir -p $BASE_DIR
cd $BASE_DIR

# all parts of ega
for OP in faops ega egaz egas alignDB withncbi
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

# make sure $HOME/bin in your $PATH
if grep -q -i homebin $HOME/.bashrc; then
    echo "==> .bashrc already contains homebin"
else
    echo "==> Update .bashrc"

    HOME_PATH='export PATH="$HOME/bin:$PATH"'
    echo '# Homebin' >> $HOME/.bashrc
    echo $HOME_PATH >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $HOME_PATH
fi
mkdir -p $HOME/bin
cd $BASE_DIR/faops && make && cp faops $HOME/bin

# settings.js
cp $BASE_DIR/ega/settings.js.example $BASE_DIR/ega/settings.js
