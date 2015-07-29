#!/usr/bin/env bash

# https://gist.github.com/revmischa/7438068

PLENV_PERL_VERSION='5.18.4'

echo "====> Building perl environment  <===="

# get plenv latest
echo "==> Cloning latest plenv..."
git clone git://github.com/tokuhirom/plenv.git $HOME/.plenv

if grep -q -i plenv $HOME/.bashrc; then
    echo "==> .bashrc already contains plenv"
else
    echo "==> Updating .bashrc with plenv bin and perl binary shims..."
    PLENV_PATH='export PATH="$HOME/.plenv/bin:$PATH"'
    PLENV_INIT='eval "$(plenv init -)"'
    echo '# plenv' >> $HOME/.bashrc
    echo $PLENV_PATH >> $HOME/.bashrc  # add plenv to path
    echo $PLENV_INIT >> $HOME/.bashrc  # shims and autocomplete
    echo >> $HOME/.bashrc

    # make the above available for the rest of this script
    eval $PLENV_PATH
    eval $PLENV_INIT
fi

echo "==> Cloning perl-build..."
git clone git://github.com/tokuhirom/Perl-Build.git $HOME/.plenv/plugins/perl-build/

echo "==> Building perl ${PLENV_PERL_VERSION}..."
mkdir -p $HOME/.plenv/cache/
if [ -e /prepare/resource/perl-5.18.4.tar.gz ]
then
  cp /prepare/resource/perl-5.18.4.tar.gz  $HOME/.plenv/cache/
fi
if [ -e /prepare/resource/perl-5.18.4.tar.bz2 ]
then
  cp /prepare/resource/perl-5.18.4.tar.bz2  $HOME/.plenv/cache/
fi

plenv install $PLENV_PERL_VERSION -Dusethreads

echo "==> Switching to $PLENV_PERL_VERSION"
plenv global $PLENV_PERL_VERSION

echo "==> Installing cpanminus..."
if [ -e /prepare/resource/cpanm ]
then
    plenv exec perl /prepare/resource/cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ ExtUtils::MakeMaker App::cpanminus
else
    plenv install-cpanm
fi

echo "==> Rehashing..."
plenv rehash

echo "plenv installation complete!"
