#!/usr/bin/env bash

CPAN_MIRROR=http://mirrors.ustc.edu.cn/CPAN/
#CPAN_MIRROR=http://www.cpan.org/

NO_TEST=--notest
#NO_TEST=

# very basic
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Archive::Extract Config::Tiny DB_File File::Find::Rule Getopt::Long::Descriptive JSON JSON::XS Text::CSV_XS YAML YAML::Syck
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::Ack App::Cmd DBI MCE Moo Moose Perl::Tidy Template WWW::Mechanize XML::Parser

# linuxbrew's pkg-config (node's dependency) override system pkg-config, and don't inherit system PKG_CONFIG_PATH
# See also https://github.com/Homebrew/linuxbrew/issues/47
#
#$ /usr/bin/pkg-config --variable pc_path pkg-config
#/usr/local/lib/x86_64-linux-gnu/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig
#$ pkg-config --variable pc_path pkg-config
#/home/vagrant/.linuxbrew/lib/pkgconfig:/home/vagrant/.linuxbrew/share/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:/home/vagrant/.linuxbrew/Library/ENV/pkgconfig/0
#
# In my current preference, I tend to use apt to install various development packages.
#export PKG_CONFIG_PATH=/usr/share/pkgconfig/:/usr/lib/x86_64-linux-gnu/pkgconfig/:$PKG_CONFIG_PATH
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST GD SVG GD::SVG

# bioperl
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Data::Stag Test::Most URI::Escape Algorithm::Munkres Array::Compare Clone Error File::Sort Graph List::MoreUtils Set::Scalar Sort::Naturally
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST HTML::Entities HTML::HeadParser HTML::TableExtract HTTP::Request::Common LWP::UserAgent PostScript::TextBlock
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST XML::DOM XML::DOM::XPath XML::LibXML XML::SAX::Writer XML::Simple XML::Twig XML::Writer GraphViz SVG::Graph
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Convert::Binary::C IO::Scalar

cpanm --mirror-only --mirror $CPAN_MIRROR --notest Bio::Perl # BioPerl
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Bio::ASN1::EntrezGene Bio::DB::EUtilities Bio::Graphics
cpanm --mirror-only --mirror $CPAN_MIRROR --notest CJFIELDS/BioPerl-Run-1.007002.tar.gz # BioPerl-Run

# circos
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Config::General Data::Dumper Digest::MD5 Font::TTF::Font Math::Bezier Math::BigFloat Math::Round Math::VecStat
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Params::Validate Readonly Regexp::Common Set::IntSpan Statistics::Basic Text::Balanced Text::Format Time::HiRes

# Bio::Phylo
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST XML::XML2JSON PDF::API2 Math::CDF Math::Random
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Bio::Phylo

# others
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST DateTime::Format::Natural DBD::CSV Path::Class File::HomeDir File::Listing File::Remove File::Copy::Recursive String::Compare
cpanm --mirror-only --mirror $CPAN_MIRROR --notest LWP::Online LWP::Protocol::https LWP::Protocol::socks

# Database and WWW
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST MongoDB Mojolicious IO::All IO::All::LWP

# text, rtf and xlsx
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Roman Text::Table Time::Duration RTF::Writer Chart::Math::Axis
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Excel::Writer::XLSX Spreadsheet::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel

# AlignDB::*
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST AlignDB::IntSpan AlignDB::IntSpanXS AlignDB::Stopwatch
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST AlignDB::Codon AlignDB::DeltaG AlignDB::GC AlignDB::SQL AlignDB::Window AlignDB::ToXLSX
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::Fasops App::RL App::Rangeops
