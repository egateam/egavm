#!/usr/bin/env bash

# https://gist.github.com/revmischa/7438068

PLENV_PERL_VERSION='5.18.4'

echo " - Building perl environment -"

# get plenv latest
echo " + Cloning latest plenv..."
git clone git://github.com/tokuhirom/plenv.git ~/.plenv

if grep -q -i plenv ~/.bashrc; then
    echo " + .bashrc already contains plenv"
else
    echo " + Updating .bashrc with plenv bin and perl binary shims..."
    PLENV_PATH='export PATH="$HOME/.plenv/bin:$PATH"'
    PLENV_INIT='eval "$(plenv init -)"'
    echo '# plenv' >> ~/.bashrc
    echo $PLENV_PATH >> ~/.bashrc  # add plenv to path
    echo $PLENV_INIT >> ~/.bashrc  # shims and autocomplete
    echo >> ~/.bashrc

    # make the above available for the rest of this script
    eval $PLENV_PATH
    eval $PLENV_INIT
fi

echo " + Cloning perl-build..."
git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/

echo " + Building perl ${PLENV_PERL_VERSION}..."
plenv install $PLENV_PERL_VERSION -Dusethreads

echo " + Switching to $PLENV_PERL_VERSION"
plenv global $PLENV_PERL_VERSION

echo " + Installing cpanminus..."
plenv install-cpanm

echo " + Rehashing..."
plenv rehash

echo "plenv installation complete!"
