#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts

cp /prepare/resource/node-v0.12.9.tar.gz `brew --cache`/node012-0.12.9.tar.gz
cp /prepare/resource/npm-2.14.9.tgz      `brew --cache`/node012--npm-2.14.9.tgz

echo "==> Install nodejs"
brew install node012

echo "==> Global node modules"
# node-gyp need node source for the first time
npm --registry=http://registry.npm.taobao.org --disturl=http://npm.taobao.org/mirrors/node -g --verbose install microtime
npm -g --verbose install bower

# npm -g install nodemon express-generator

echo "==> Node modules"
cd $BASE_DIR/ega
npm --verbose install

echo "==> bower modules"
cd $BASE_DIR/ega
bower --config.analytics=false install

# settings.js
cp $BASE_DIR/ega/settings.js.example $BASE_DIR/ega/settings.js

# in a VM
if [[ `whoami` == 'vagrant' ]];
then
    echo "==> Remove file size limits in VM"
    perl -npi -e 's{file_size_limit\:.+}{file_size_limit\: 999 \* 1024 \* 1024 \/\/ 999 MB}' $BASE_DIR/ega/settings.js
    perl -npi -e 's{data\-validation\-max\-size\=\"30M\"}{data\-validation\-max\-size="999M"}' $BASE_DIR/ega/views/upload.jade
    perl -npi -e 's{Single file size limit\: 30MB}{Single file size limit\: 999MB}' $BASE_DIR/ega/public/javascripts/app.js
fi
