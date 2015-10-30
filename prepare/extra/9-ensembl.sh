#!/usr/bin/env bash

export ENSEMBL_VERSION='82'

cd /prepare/resource

if [ ! -e /prepare/resource/ensembl-${ENSEMBL_VERSION}.tar.gz ];
then
    echo "==> Get ensembl tarballs"
    wget https://github.com/Ensembl/ensembl/archive/release/${ENSEMBL_VERSION}.tar.gz           -O ensembl-${ENSEMBL_VERSION}.tar.gz
    wget https://github.com/Ensembl/ensembl-compara/archive/release/${ENSEMBL_VERSION}.tar.gz   -O ensembl-compara-${ENSEMBL_VERSION}.tar.gz
    wget https://github.com/Ensembl/ensembl-variation/archive/release/${ENSEMBL_VERSION}.tar.gz -O ensembl-variation-${ENSEMBL_VERSION}.tar.gz
fi

echo "==> ensembl"
tar xfz /prepare/resource/ensembl-${ENSEMBL_VERSION}.tar.gz ensembl-release-${ENSEMBL_VERSION}/modules/Bio/EnsEMBL
cp -R ensembl-release-${ENSEMBL_VERSION}/modules/Bio `perl -e 'print grep {/site_perl/ and /plenv/} grep {!/darwin/i and !/x86_64/} @INC'`

echo "==> ensembl-compara"
tar xfz /prepare/resource/ensembl-compara-${ENSEMBL_VERSION}.tar.gz ensembl-compara-release-${ENSEMBL_VERSION}/modules/Bio/EnsEMBL
cp -R ensembl-compara-release-${ENSEMBL_VERSION}/modules/Bio `perl -e 'print grep {/site_perl/ and /plenv/} grep {!/darwin/i and !/x86_64/} @INC'`

echo "==> ensembl-variation"
tar xfz /prepare/resource/ensembl-variation-${ENSEMBL_VERSION}.tar.gz ensembl-variation-release-${ENSEMBL_VERSION}/modules/Bio/EnsEMBL
cp -R ensembl-variation-release-${ENSEMBL_VERSION}/modules/Bio `perl -e 'print grep {/site_perl/ and /plenv/} grep {!/darwin/i and !/x86_64/} @INC'`

rm -fr ensembl-release-${ENSEMBL_VERSION}
rm -fr ensembl-compara-release-${ENSEMBL_VERSION}
rm -fr ensembl-variation-release-${ENSEMBL_VERSION}

perl -MBio::EnsEMBL::Root -e 'print qq{If you see this, means ensembl installation successful.\n}'

unset ENSEMBL_VERSION
