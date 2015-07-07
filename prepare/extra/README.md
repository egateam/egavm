This fold contains extra dependency for `alignDB` and some libraries and tools I used frequently.

For `DBD::mysql`:
* `cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --look DBD::mysql`
* `perl Makefile.pl --testuser alignDB --testpassword alignDB`
* `make && make test && make install`

For `Ensembl`:
* Download `ensembl-65.tar.gz`, `ensembl-compara-65.tar.gz` and `ensembl-variation-65.tar.gz` from [ensembl's cvs server](http://cvs.sanger.ac.uk/cgi-bin/viewvc.cgi/?root=ensembl).
* Newer version (>77) can be found in [github](https://github.com/Ensembl/ensembl).
* Extract tar ball files and copy modules/Bio/EnsEMBL to perl module directory. For this VM, that is `.plenv/versions/5.18.4/lib/perl5/site_perl/5.18.4/Bio/`.
