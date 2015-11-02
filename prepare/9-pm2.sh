#!/usr/bin/env bash

echo "Make ega available on startup"

npm -g --verbose install pm2@latest
pm2 update

sudo env PATH=$PATH:/home/vagrant/.linuxbrew/bin pm2 startup ubuntu -u vagrant

cd ~/Scripts/ega
pm2 start app.js
