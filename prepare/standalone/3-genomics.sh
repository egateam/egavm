#!/usr/bin/env bash

mkdir -p $HOME/share/

echo "====> Building Genomics related tools <===="

echo "==> python"
brew install python
pip install --upgrade pip setuptools

echo "==> other tools"
brew install cmake
brew install samtools bamtools htslib bowtie bowtie2
brew install tophat cufflinks
brew install fastqc picard-tools
brew install sickle

echo "==> custom tap"
brew tap wang-q/tap
brew install scythe

echo "==> trinity"
#brew install trinity
cd /prepare/resource/
wget -N https://github.com/trinityrnaseq/trinityrnaseq/archive/v2.0.6.tar.gz

cd $HOME/share/
tar xvfz /prepare/resource/v2.0.6.tar.gz

cd $HOME/share/trinityrnaseq-*
make
make plugins
