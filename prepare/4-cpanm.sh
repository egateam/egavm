#!/usr/bin/env bash

# very basic
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Carp Cwd Config::Tiny DB_File File::Find::Rule GD JSON JSON::XS Text::CSV Text::CSV_XS YAML
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ DBI MCE Moose Template
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest App::Ack EV AnyEvent POE WWW::Mechanize

# bioperl
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Data::Stag Test::Most URI::Escape Algorithm::Munkres Array::Compare Clone Error File::Sort Graph IO::Scalar List::MoreUtils Set::Scalar Sort::Naturally
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ HTML::Entities HTML::HeadParser HTML::TableExtract HTTP::Request::Common LWP::UserAgent PostScript::TextBlock
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ XML::DOM XML::DOM::XPath XML::LibXML XML::SAX::Writer XML::Simple XML::Twig XML::Writer GraphViz SVG SVG::Graph GD::SVG
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest Convert::Binary::C YAML::Syck

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest Bio::Perl # BioPerl
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Bio::ASN1::EntrezGene Bio::Graphics Bio::DB::EUtilities
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest Bio::Tools::Run::Alignment::Clustalw # BioPerl-Run

# circos
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Config::General Data::Dumper Digest::MD5 Font::TTF::Font GD::Polyline Math::Bezier Math::BigFloat Math::Round Math::VecStat
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Params::Validate Readonly Regexp::Common Set::IntSpan Statistics::Basic Text::Balanced Text::Format Time::HiRes

# Bio::Phylo
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ XML::XML2JSON PDF::API2 Math::CDF Math::Random
cpanm --notest Bio::Phylo

# AlignDB::*
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::IntSpan AlignDB::Util AlignDB::Stopwatch AlignDB::Codon
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Run AlignDB::Window App::Fasops

# others
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ DateTime::Format::Natural File::HomeDir DBD::CSV Path::Class File::Listing File::Remove File::Rename File::Copy::Recursive String::Compare
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest LWP::Online LWP::Protocol::https
