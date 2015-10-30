#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts

echo "==> Install nodejs"
brew install node

echo "==> Global node modules"
npm -g install nodemon
npm -g install pm2
npm -g install bower
npm -g install express-generator

echo "==> Node modules"
cd $BASE_DIR/ega
npm install
bower --config.analytics=false install

# settings.js
cp $BASE_DIR/ega/settings.js.example $BASE_DIR/ega/settings.js

if [[ `whoami` == 'vagrant' ]];
then
    echo "==> Remove file size limits in VM"
    perl -npi -e 's{file_size_limit\:.+}{file_size_limit\: 999 \* 1024 \* 1024 \/\/ 999 MB}' $BASE_DIR/ega/settings.js
    perl -npi -e 's{data\-validation\-max\-size\=\"30M\"}{data\-validation\-max\-size="999M"}' $BASE_DIR/ega/views/upload.jade
fi
