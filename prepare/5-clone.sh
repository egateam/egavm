#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts
mkdir -p $BASE_DIR
cd $BASE_DIR

# all parts of ega
for OP in ega egaz egas egavm alignDB withncbi
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
