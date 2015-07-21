#!/usr/bin/env bash

if [ -e /prepare/resource/ensembl.tar.gz ]; then
    cd /prepare/resource/

    echo "==> ensembl"
    tar xfz /prepare/resource/ensembl.tar.gz ensembl/modules/Bio/EnsEMBL
    cp -R ensembl/modules/Bio `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`

    echo "==> ensembl-compara"
    tar xfz /prepare/resource/ensembl-compara.tar.gz ensembl-compara/modules/Bio/EnsEMBL
    cp -R ensembl-compara/modules/Bio `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`

    echo "==> ensembl-variation"
    tar xfz /prepare/resource/ensembl-variation.tar.gz ensembl-variation/modules/Bio/EnsEMBL
    cp -R ensembl-variation/modules/Bio `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`

    rm -fr ensembl
    rm -fr ensembl-compara
    rm -fr ensembl-variation

    perl -MBio::EnsEMBL::Root -e 'print qq{If you see this, means ensembl installation successful.\n}'
else
    echo "Ensembl Tarballs don't exist."
fi
