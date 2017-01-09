#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts

echo "==> Install nodejs"
brew install node@6

echo "==> Set npm mirrors"
npm config set registry https://registry.npm.taobao.org
echo "    Npm set to " $(npm config get registry)

echo "==> Global node modules"
# node-gyp need node source for the first time
npm --registry=http://registry.npm.taobao.org --disturl=http://npm.taobao.org/mirrors/node -g install microtime
npm -g install bower

# npm -g install nodemon express-generator

echo "==> Local Node modules"
cd $BASE_DIR/ega
npm install

echo "==> bower modules"
cd $BASE_DIR/ega
bower --config.analytics=false install

# settings.js
if [ ! -e $BASE_DIR/ega/settings.js ]
then
    cp $BASE_DIR/ega/settings.js.example $BASE_DIR/ega/settings.js
fi

# in a VM
if [[ $(whoami) == 'vagrant' ]];
then
    echo "==> Remove file size limits in VM"
    perl -npi -e 's{file_size_limit\:.+}{file_size_limit\: 999 \* 1024 \* 1024 \/\/ 999 MB}' $BASE_DIR/ega/settings.js
    perl -npi -e 's{data\-validation\-max\-size\=\"30M\"}{data\-validation\-max\-size="999M"}' $BASE_DIR/ega/views/upload.jade
    perl -npi -e 's{Single file size limit\: 30MB}{Single file size limit\: 999MB}' $BASE_DIR/ega/public/javascripts/app.js
fi
