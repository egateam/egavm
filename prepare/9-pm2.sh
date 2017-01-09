#!/usr/bin/env bash

echo "Make ega available on startup"

npm -g --verbose install pm2@latest
pm2 update

sudo env PATH=$PATH:$HOME/.linuxbrew/bin pm2 startup upstart -u `whoami`

cd ~/Scripts/ega
pm2 start app.js

# Enable non root user access port 80
# https://www.digitalocean.com/community/tutorials/how-to-use-pm2-to-setup-a-node-js-production-environment-on-an-ubuntu-vps
#ls -al `which node`
#sudo apt-get install libcap2-bin
#sudo setcap cap_net_bind_service=+ep /home/wangq/.linuxbrew/Cellar/node@6/6.9.4/bin/node

#  Get basic info
# pm2 desc 0
