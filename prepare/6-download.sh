#!/usr/bin/env bash

mkdir -p $HOME/share/

# blast
cd /prepare/resource/
wget -N http://ftp.ncbi.nlm.nih.gov/blast/executables/release/LATEST/blast-2.2.26-x64-linux.tar.gz
cd $HOME/share/
tar xvfz /prepare/resource/blast-2.2.26-x64-linux.tar.gz
mv blast-2.2.26 blast

# circos
cd /prepare/resource/
#curl http://circos.ca/distribution/circos-0.67-7.tgz -O
wget -N http://science-annex.org/pub/circos/circos-0.67-7.tgz
cd $HOME/share/
tar xvfz /prepare/resource/circos-0.67-7.tgz
mv circos-0.67-7 circos

# multiz
cd /prepare/resource/
wget -N http://www.bx.psu.edu/miller_lab/dist/multiz-tba.012109.tar.gz -O
cd $HOME/share/
tar xvfz /prepare/resource/multiz-tba.012109.tar.gz
cd multiz-tba*
sed -i 's/\-Werror//' Makefile
perl -npi -e 's/\/depot\/apps\/\$\(ARCH\)\/bin/\~\/bin/' Makefile
make
make install
rm -fr $HOME/share/multiz-tba*
