#!/usr/bin/env bash

# make sure $HOME/bin in your $PATH
if grep -q -i homebin $HOME/.bashrc; then
    echo "==> .bashrc already contains homebin"
else
    echo "==> Update .bashrc"

    HOME_PATH='export PATH="$HOME/bin:$PATH"'
    echo '# Homebin' >> $HOME/.bashrc
    echo $HOME_PATH >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $HOME_PATH
fi

mkdir -p $HOME/bin
mkdir -p $HOME/share/

echo "==> blast"
cd /prepare/resource/
wget -N http://ftp.ncbi.nlm.nih.gov/blast/executables/release/LATEST/blast-2.2.26-x64-linux.tar.gz
cd $HOME/share/
rm -fr blast
tar xvfz /prepare/resource/blast-2.2.26-x64-linux.tar.gz
mv blast-2.2.26 blast

echo "==> circos"
cd /prepare/resource/
wget -N http://science-annex.org/pub/circos/circos-0.67-7.tgz
cd $HOME/share/
rm -fr circos
tar xvfz /prepare/resource/circos-0.67-7.tgz
mv circos-0.67-7 circos

echo "==> jvarkit"
cd /prepare/resource/
if [ ! -e 1.139.zip ];
then
    wget -N https://github.com/samtools/htsjdk/archive/1.139.zip
fi
cd $HOME/share/
rm -fr jvarkit
git clone "https://github.com/wang-q/jvarkit.git"
cp /prepare/resource/1.139.zip $HOME/share/jvarkit/

cd jvarkit
perl -nli -e '/samtools\/htsjdk/ and next; print' Makefile
make biostar94573
cp dist*/biostar94573.jar .

echo "==> kent bin"
cd $HOME/bin/
if [[ `uname` == 'Darwin' ]];
then
    JKBIN_TAR_GZ=/prepare/resource/jkbin-darwin-2011.tar.gz
else
    JKBIN_TAR_GZ=/prepare/resource/jkbin-ubuntu-1404-2011.tar.gz
fi
echo "==> untar from ${JKBIN_TAR_GZ}"
tar xvfz ${JKBIN_TAR_GZ} x86_64/axtChain
tar xvfz ${JKBIN_TAR_GZ} x86_64/axtSort
tar xvfz ${JKBIN_TAR_GZ} x86_64/axtToMaf
tar xvfz ${JKBIN_TAR_GZ} x86_64/chainAntiRepeat
tar xvfz ${JKBIN_TAR_GZ} x86_64/chainMergeSort
tar xvfz ${JKBIN_TAR_GZ} x86_64/chainNet
tar xvfz ${JKBIN_TAR_GZ} x86_64/chainPreNet
tar xvfz ${JKBIN_TAR_GZ} x86_64/chainSplit
tar xvfz ${JKBIN_TAR_GZ} x86_64/chainStitchId
tar xvfz ${JKBIN_TAR_GZ} x86_64/faToTwoBit
tar xvfz ${JKBIN_TAR_GZ} x86_64/lavToPsl
tar xvfz ${JKBIN_TAR_GZ} x86_64/mafSpeciesList
tar xvfz ${JKBIN_TAR_GZ} x86_64/netChainSubset
tar xvfz ${JKBIN_TAR_GZ} x86_64/netFilter
tar xvfz ${JKBIN_TAR_GZ} x86_64/netSplit
tar xvfz ${JKBIN_TAR_GZ} x86_64/netSyntenic
tar xvfz ${JKBIN_TAR_GZ} x86_64/netToAxt
