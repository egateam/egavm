#!/usr/bin/env bash

echo "====> Linuxbrew environment  <===="

echo "==> Clone latest linuxbrew"
git clone https://github.com/Linuxbrew/brew.git $HOME/.linuxbrew

if grep -q -i linuxbrew $HOME/.bashrc; then
    echo "==> .bashrc already contains linuxbrew"
else
    echo "==> Update .bashrc"

    LB_PATH='export PATH="$HOME/.linuxbrew/bin:$PATH"'
    LB_MAN='export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"'
    LB_INFO='export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"'
    echo '# Linuxbrew' >> $HOME/.bashrc
    echo $LB_PATH >> $HOME/.bashrc
    echo $LB_MAN  >> $HOME/.bashrc
    echo $LB_INFO >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $LB_PATH
    eval $LB_MAN
    eval $LB_INFO
fi

#echo "==> Check brew with doctor"
#brew doctor

echo "==> Add tap science"
brew tap homebrew/science
brew tap wang-q/tap

# Many bioinfomatics hosted on low band server, so don't waste time on downloading them repeatedly.
mkdir -p $HOME/.cache/Homebrew
rm $HOME/.cache/Homebrew/*.incomplete

cp /prepare/resource/ncbi-rmblastn-2.2.28-x64-linux.tar.gz  `brew --cache`/rmblast-2.2.28.tar.gz
cp /prepare/resource/RepeatMasker-open-4-0-7.tar.gz         `brew --cache`/repeatmasker-4.0.7.tar.gz

echo "==> Install bioinfomatics softwares"
brew install clustal-w hmmer lastz mafft raxml
brew install blast --without-check # this will not install boost
brew install rmblast --without-blast
brew install repeatmasker --without-configure # run config later

echo "==> Install Java"
brew install jdk ant

echo "==> Install R"
brew install r --without-x11
Rscript -e 'install.packages("getopt", repos="https://mirrors.tuna.tsinghua.edu.cn/CRAN")'
Rscript -e 'install.packages("ape", repos="https://mirrors.tuna.tsinghua.edu.cn/CRAN")'

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest Statistics::R

echo "==> Install vcftools"
brew install vcftools
cp $HOME/.linuxbrew/lib/perl5/site_perl/FaSlice.pm  $(perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC')
cp $HOME/.linuxbrew/lib/perl5/site_perl/Vcf.pm      $(perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC')
cp $HOME/.linuxbrew/lib/perl5/site_perl/VcfStats.pm $(perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC')

echo "==> Install wang-q/tap"
brew install faops multiz sparsemem
brew install jrunlist jrange

echo "==> Config repeatmasker"
cd $(brew --prefix)/Cellar/$(brew list --versions repeatmasker | sed 's/ /\//')/libexec
tar zxvf /prepare/resource/repeatmaskerlibraries-20140131.tar.gz
sed -i".bak" 's/\/usr\/bin\/perl/env/' config.txt
./configure < config.txt

rm $(brew --prefix)/bin/rmOutToGFF3.pl
sed -i".bak" 's/::Bin/::RealBin/' $(brew --prefix)/Cellar/$(brew list --versions repeatmasker | sed 's/ /\//')/libexec/util/rmOutToGFF3.pl
ln -s $(brew --prefix)/Cellar/$(brew list --versions repeatmasker | sed 's/ /\//')/libexec/util/rmOutToGFF3.pl $(brew --prefix)/bin/rmOutToGFF3.pl
