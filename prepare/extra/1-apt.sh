#!/usr/bin/env bash

# softwares via apt-get
echo "====> Install extra softwares via apt-get -"

echo "==> Install gtk3"
sudo apt-get -y install libcairo2-dev libglib2.0-0 libglib2.0-dev libgtk-3-dev libgirepository1.0-dev
sudo apt-get -y install gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-webkit-3.0

echo "==> Install gtk3 related tools"
sudo apt-get -y install xvfb glade

echo "==> Install gsl"
sudo apt-get -y install libgsl0ldbl libgsl0-dev

echo "==> Install r"
sudo apt-get -y install r-base r-base-dev

echo "Software installation complete!"
