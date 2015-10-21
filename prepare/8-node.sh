#!/usr/bin/env bash

BASE_DIR=$HOME/Scripts

echo "==> Install nodejs"
brew install node

echo "==> Node modules"
cd $BASE_DIR/ega

npm -g install nodemon
npm -g install bower
npm -g install express-generator

npm install
bower --config.analytics=false install

# settings.js
cp $BASE_DIR/ega/settings.js.example $BASE_DIR/ega/settings.js
