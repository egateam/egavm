#!/usr/bin/env bash

echo " - Linuxbrew environment -"

echo " + Clone latest linuxbrew"
git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew

echo " + Update .bashrc"

LB_PATH='export PATH="$HOME/.linuxbrew/bin:$PATH"'
LB_MAN='export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"'
LB_INFO='export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"'
echo '# Linuxbrew' >> ~/.bashrc
echo $LB_PATH >> ~/.bashrc
echo $LB_MAN  >> ~/.bashrc
echo $LB_INFO >> ~/.bashrc

eval $LB_PATH
eval $LB_MAN
eval $LB_INFO

echo " + Check brew with doctor"
brew doctor

echo " + Add tap science"
brew tap homebrew/science

echo " + Install nodejs"
brew install node

#berkeley-db   bzip2	  freetype  hmmer  libmpc   mpfr	  pcre	      rmblast
#berkeley-db4  cloog	  gcc	    isl    libpng   newick-utils  pkg-config  sqlite
#blast	      clustal-w   gd	    jpeg   libtiff  node	  raxml       trf
#boost	      fontconfig  gmp	    lastz  mafft    parallel	  readline    xz

echo " + Install other softwares"
brew install parallel gd libxml2 berkeley-db4
brew install clustal-w hmmer lastz mafft newick-utils raxml
#brew install blast --without-check # this will not install boost
brew install rmblast --without-blast
brew install repeatmasker --without-configure # run config later
