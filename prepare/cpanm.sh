#!/usr/bin/env bash

# very basic
cpanm App::Ack Carp Cwd Config::Tiny DBI DB_File File::Find::Rule GD MCE Moose JSON JSON::XS Text::CSV_XS YAML

# bioperl
cpanm Data::Stag Test::Most URI::Escape
cpanm Algorithm::Munkres Array::Compare Clone Error File::Sort Graph IO::Scalar List::MoreUtils Set::Scalar Sort::Naturally
cpanm HTML::Entities HTML::HeadParser HTML::TableExtract HTTP::Request::Common LWP::UserAgent PostScript::TextBlock
cpanm XML::DOM XML::DOM::XPath XML::LibXML XML::SAX::Writer XML::Simple XML::Twig XML::Writer GraphViz SVG SVG::Graph GD::SVG
cpanm --notest Convert::Binary::C YAML::Syck

cpanm Bio::Perl
cpanm Bio::ASN1::EntrezGene Bio::Graphics
cpanm Bio::DB::EUtilities
cpanm --notest Bio::Tools::Run::Alignment::Clustalw

# circos
cpanm Config::General Data::Dumper Digest::MD5 Font::TTF::Font GD::Polyline Math::Bezier Math::BigFloat Math::Round Math::VecStat 
cpanm Params::Validate Readonly Regexp::Common Set::IntSpan Statistics::Basic Text::Balanced Text::Format Time::HiRes

# Bio::Phylo
cpanm XML::XML2JSON PDF::API2 Math::CDF Math::Random
cpanm --notest Bio::Phylo

# AlignDB::
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::IntSpan
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Util
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Stopwatch
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master AlignDB::Codon
