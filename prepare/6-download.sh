#!/usr/bin/env bash

mkdir -p $HOME/share/

echo "==> blast"
cd /prepare/resource/
wget -N http://ftp.ncbi.nlm.nih.gov/blast/executables/release/LATEST/blast-2.2.26-x64-linux.tar.gz
cd $HOME/share/
tar xvfz /prepare/resource/blast-2.2.26-x64-linux.tar.gz
mv blast-2.2.26 blast

echo "==> circos"
cd /prepare/resource/
wget -N http://science-annex.org/pub/circos/circos-0.67-7.tgz
cd $HOME/share/
tar xvfz /prepare/resource/circos-0.67-7.tgz
mv circos-0.67-7 circos

echo "==> multiz"
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

echo "==> jvarkit"
cd $HOME/share/
rm -fr jvarkit
git clone "https://github.com/lindenb/jvarkit.git"
cd jvarkit
make biostar94573
cp dist*/biostar94573.jar .

echo "==> kent bin"
cd $HOME/bin/
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/axtChain
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/axtSort
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/axtToMaf
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/chainAntiRepeat
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/chainMergeSort
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/chainNet
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/chainPreNet
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/chainSplit
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/chainStitchId
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/faSize
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/faToTwoBit
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/lavToPsl
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/mafSpeciesList
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/netChainSubset
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/netFilter
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/netSplit
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/netSyntenic
tar xvfz /prepare/resource/jkbin-ubuntu-1404-2011.tar.gz x86_64/netToAxt
