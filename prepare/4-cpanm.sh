#!/usr/bin/env bash

# very basic
cpanm App::Ack Carp Cwd Config::Tiny DB_File File::Find::Rule GD JSON JSON::XS Text::CSV_XS YAML
cpanm DBI MCE Moose POE Template WWW::Mechanize

# bioperl
cpanm Data::Stag Test::Most URI::Escape
cpanm Algorithm::Munkres Array::Compare Clone Error File::Sort Graph IO::Scalar List::MoreUtils Set::Scalar Sort::Naturally
cpanm HTML::Entities HTML::HeadParser HTML::TableExtract HTTP::Request::Common LWP::UserAgent PostScript::TextBlock
cpanm XML::DOM XML::DOM::XPath XML::LibXML XML::SAX::Writer XML::Simple XML::Twig XML::Writer GraphViz SVG SVG::Graph GD::SVG
cpanm --notest Convert::Binary::C YAML::Syck

cpanm --notest Bio::Perl # BioPerl
cpanm Bio::ASN1::EntrezGene Bio::Graphics
cpanm Bio::DB::EUtilities
cpanm --notest Bio::Tools::Run::Alignment::Clustalw # BioPerl-Run

# circos
cpanm Config::General Data::Dumper Digest::MD5 Font::TTF::Font GD::Polyline Math::Bezier Math::BigFloat Math::Round Math::VecStat 
cpanm Params::Validate Readonly Regexp::Common Set::IntSpan Statistics::Basic Text::Balanced Text::Format Time::HiRes

# Bio::Phylo
cpanm XML::XML2JSON PDF::API2 Math::CDF Math::Random
cpanm --notest Bio::Phylo

# AlignDB::*
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::IntSpan
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Util
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Stopwatch
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Codon
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Run
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Window
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master App::Fasops

# others
cpanm DateTime::Format::Natural File::HomeDir DBD::CSV Path::Class File::Remove File::Copy::Recursive String::Compare
