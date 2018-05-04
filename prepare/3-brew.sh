#!/usr/bin/env bash

echo "====> Linuxbrew environment  <===="

brew install hello

mkdir -p $HOME/.cache/Homebrew
rm -f $HOME/.cache/Homebrew/*.incomplete

# taps
echo "==> Add brew taps"
brew tap brewsci/bio
brew tap brewsci/science
brew tap wang-q/tap

echo "==> Install basic dependencies"
brew install gdbm berkeley-db expat libedit readline sqlite openssl

# only keep the latest version
# `brew list --versions` may list multiple versions
brew cleanup --force

# perl
echo "==> Install Perl 5.26"
brew install perl

if grep -q -i PERL_526_PATH $HOME/.bashrc; then
    echo "==> .bashrc already contains PERL_526_PATH"
else
    echo "==> Updating .bashrc with PERL_526_PATH..."
    PERL_526_BREW=$(brew --prefix)/Cellar/$(brew list --versions perl | sed 's/ /\//')
    PERL_526_PATH="export PATH=\"$PERL_526_BREW/bin:\$PATH\""
    BREW_SITE_PERL="export PERL5LIB=\"$(brew --prefix)/lib/perl5/site_perl:\$PERL5LIB\""
    echo '# PERL_526_PATH' >> $HOME/.bashrc
    echo $PERL_526_PATH    >> $HOME/.bashrc
    echo $BREW_SITE_PERL   >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    # make the above environment variables available for the rest of this script
    eval $PERL_526_PATH
    eval $BREW_SITE_PERL
fi

curl -L https://cpanmin.us | perl - App::cpanminus
cpanm --notest XML::Parser XML::SAX

# python
echo "==> Install Python 3"
brew install python

if grep -q -i PYTHON_3_PATH $HOME/.bashrc; then
    echo "==> .bashrc already contains PYTHON_3_PATH"
else
    echo "==> Updating .bashrc with PYTHON_3_PATH..."
    PYTHON_3_PATH="export PATH=\"$(brew --prefix)/opt/python/libexec/bin:\$PATH\""
    echo '# PYTHON_3_PATH' >> $HOME/.bashrc
    echo $PYTHON_3_PATH    >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    # make the above environment variables available for the rest of this script
    eval $PYTHON_3_PATH
fi

pip3 install --upgrade pip setuptools

echo "==> Install R"
brew install r
Rscript -e 'install.packages("getopt", repos="https://mirrors.tuna.tsinghua.edu.cn/CRAN")'
Rscript -e 'install.packages("ape", repos="https://mirrors.tuna.tsinghua.edu.cn/CRAN")'

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest Statistics::R

echo "==> Install Java"

if [ -e /prepare/resource/jdk-9.0.1+11.x86_64_linux.bottle.tar.gz ]; then
    hash java 2>/dev/null || {
        pushd $(brew --prefix)/Cellar
        tar xf /prepare/resource/jdk-*bottle*tar.gz && brew link jdk
        popd
    }
else
    brew install jdk
fi
brew install ant maven

#echo "==> Install mysql"
#cp /prepare/resource/mysql-*bottle*tar.gz $(brew --cache)/
#brew install mysql
#brew unlink mysql

echo "==> Install bioinfomatics softwares"

# Some bioinfomatics hosted on low band server, so don't waste time on downloading them repeatedly.
cp /prepare/resource/blast-2.7.1.x86_64_linux.bottle.tar.gz $(brew --cache)/
cp /prepare/resource/RepeatMasker-open-4-0-7.tar.gz         $(brew --cache)/repeatmasker-4.0.7.tar.gz

brew install --force-bottle blast
brew install --force-bottle rmblast
brew install brewsci/bio/clustal-w
brew install hmmer lastz mafft raxml
brew install vcftools
brew install repeatmasker --build-from-source # run config later

echo "==> Install wang-q/tap"
brew install faops multiz sparsemem
brew install jrunlist jrange

echo "==> Config repeatmasker"
pushd $(brew --prefix)/opt/repeatmasker/libexec
rm -fr lib/perl5/x86_64-linux-thread-multi/
rm Libraries/RepeatMasker.lib*
rm Libraries/DfamConsensus.embl
popd
pushd $(brew --prefix)/Cellar/$(brew list --versions repeatmasker | sed 's/ /\//')/libexec
tar zxvf /prepare/resource/repeatmaskerlibraries-20140131.tar.gz
sed -i".bak" 's/\/usr\/bin\/perl/env/' config.txt
./configure < config.txt
popd

# TODO: remove these
rm $(brew --prefix)/bin/rmOutToGFF3.pl
sed -i".bak" 's/::Bin/::RealBin/' $(brew --prefix)/Cellar/$(brew list --versions repeatmasker | sed 's/ /\//')/libexec/util/rmOutToGFF3.pl
ln -s $(brew --prefix)/Cellar/$(brew list --versions repeatmasker | sed 's/ /\//')/libexec/util/rmOutToGFF3.pl $(brew --prefix)/bin/rmOutToGFF3.pl
