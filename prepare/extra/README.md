This fold contains extra dependency for `alignDB` and some libraries and tools I used frequently.

For `Ensembl`:

* Old version (e.g. 65) `ensembl.tar.gz`, `ensembl-compara.tar.gz` and `ensembl-variation.tar.gz` 
from [ensembl's cvs server](http://cvs.sanger.ac.uk/cgi-bin/viewvc.cgi/?root=ensembl).

* Newer version (>77) can be found in [github](https://github.com/Ensembl/ensembl).

* Extract tar ball files and copy modules/Bio/EnsEMBL to perl module directory. For this VM, that is
`.plenv/versions/5.18.4/lib/perl5/site_perl/5.18.4/Bio/`.
