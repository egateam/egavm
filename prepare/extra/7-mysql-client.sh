#!/usr/bin/env bash

rm `brew --cache`/*.incomplete
cp /prepare/resource/mysql-5.1.73.tar.gz    `brew --cache`/mysql51-5.1.73.tar.gz
cp /prepare/resource/openssl-1.0.2c.tar.gz  `brew --cache`/openssl-1.0.2c.tar.gz

brew tap homebrew/versions
brew install mysql51 --without-server

if grep -q -i mysqlbin $HOME/.bashrc; then
    echo "==> .bashrc already contains mysqlbin"
else
    echo "==> Update .bashrc"

    LB_PATH='export PATH="$HOME/.linuxbrew/Cellar/mysql51/5.1.73_1/bin:$PATH"'
    echo '# mysqlbin' >> $HOME/.bashrc
    echo $LB_PATH >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $LB_PATH
fi

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest DBD::mysql
