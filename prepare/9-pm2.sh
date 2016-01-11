#!/usr/bin/env bash

echo "Make ega available on startup"

npm -g --verbose install pm2@latest
pm2 update

sudo env PATH=$PATH:$HOME/.linuxbrew/bin pm2 startup ubuntu -u `whoami`

cd ~/Scripts/ega
pm2 start app.js

# Enable non root user access port 80
#ls -al `which node`
#sudo apt-get install libcap2-bin
#sudo setcap cap_net_bind_service=+ep /home/ega/.linuxbrew/Cellar/node012/0.12.7/bin/node

#  Get basic info
# pm2 desc 0
