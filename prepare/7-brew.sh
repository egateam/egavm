#!/usr/bin/env bash

echo " - Linuxbrew environment -"

echo " + Clone latest linuxbrew"
git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew

if grep -q -i linuxbrew ~/.bashrc; then
    echo " + .bashrc already contains linuxbrew"
else
    echo " + Update .bashrc"

    LB_PATH='export PATH="$HOME/.linuxbrew/bin:$PATH"'
    LB_MAN='export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"'
    LB_INFO='export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"'
    echo '# Linuxbrew' >> ~/.bashrc
    echo $LB_PATH >> ~/.bashrc
    echo $LB_MAN  >> ~/.bashrc
    echo $LB_INFO >> ~/.bashrc
    echo >> ~/.bashrc

    eval $LB_PATH
    eval $LB_MAN
    eval $LB_INFO
fi

echo " + Check brew with doctor"
brew doctor

echo " + Add tap science"
brew tap homebrew/science

# Many bioinfomatics hosted on low band server, so don't waste time on downloading them repeatedly.
rm ~/.cache/Homebrew/*.incomplete
cp /prepare/resource/newick-utils-1.6.tar.gz                ~/.cache/Homebrew/newick-utils-1.6.tar.gz
cp /prepare/resource/pcre-8.37.tar.bz2                      ~/.cache/Homebrew/pcre-8.37.tar.bz2
cp /prepare/resource/ncbi-rmblastn-2.2.28-x64-linux.tar.gz  ~/.cache/Homebrew/ncbi-rmblastn-2.2.28-x64-linux.tar.gz
cp /prepare/resource/RepeatMasker-open-4-0-5.tar.gz         ~/.cache/Homebrew/repeatmasker-4.0.5.tar.gz
cp /prepare/resource/standard-RAxML-8.1.15.tar.gz           ~/.cache/Homebrew/raxml-8.1.15.tar.gz
cp /prepare/resource/ncbi-blast-2.2.31+src.tar.gz           ~/.cache/Homebrew/blast-2.2.31.tar.gz

echo " + Install bioinfomatics softwares"
brew install clustal-w hmmer lastz mafft newick-utils raxml
brew install blast --without-check # this will not install boost
brew install rmblast --without-blast
brew install repeatmasker --without-configure # run config later

echo " + Install vcftools"
brew install vcftools
cp $HOME/.linuxbrew/lib/perl5/site_perl/FaSlice.pm  `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`
cp $HOME/.linuxbrew/lib/perl5/site_perl/Vcf.pm      `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`
cp $HOME/.linuxbrew/lib/perl5/site_perl/VcfStats.pm `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`
