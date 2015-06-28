#!/usr/bin/env bash

# softwares via apt-get
sudo sed -i 's/us.archive.ubuntu.com/mirrors.ustc.edu.cn/' /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
sudo apt-get -y install openjdk-7-jre
sudo apt-get -y install vim graphviz

# mongodb
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get -y update
sudo apt-get install -y mongodb-org

# redis
sudo apt-get -y install redis-server

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