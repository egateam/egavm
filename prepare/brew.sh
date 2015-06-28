#!/usr/bin/env bash

# linuxbrew
git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew

echo '# Linuxbrew' >> ~/.bashrc
echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> ~/.bashrc
echo 'export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"' >> ~/.bashrc
echo 'export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"' >> ~/.bashrc

source ~/.bashrc
brew doctor

brew tap homebrew/science

# nodejs
brew install node
npm --verbose -g install nodemon
npm --verbose -g install bower
npm --verbose -g install express-generator

#berkeley-db   bzip2	  freetype  hmmer  libmpc   mpfr	  pcre	      rmblast
#berkeley-db4  cloog	  gcc	    isl    libpng   newick-utils  pkg-config  sqlite
#blast	      clustal-w   gd	    jpeg   libtiff  node	  raxml       trf
#boost	      fontconfig  gmp	    lastz  mafft    parallel	  readline    xz