#!/usr/bin/env bash

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ `uname` == 'Darwin' ]]; then
    if [ hash packer 2> /dev/null ]; then
        echo "==> Install packer via brew"
        brew install packer
    else
        echo "==> Found packer in PATH"
    fi
fi

echo "==> Build Ubuntu box"
cd ${BASE_DIR}

if [[ ! -e ${BASE_DIR}/../vm/mytrusty.box ]]; then
    packer build template.json
    mv mytrusty.box ${BASE_DIR}/../vm
fi

echo "==> Add base box"
vagrant box add mytrusty ${BASE_DIR}/../vm/mytrusty.box --force
