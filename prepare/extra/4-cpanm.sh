#!/usr/bin/env bash

# This is a minimal set of modules, which means all intermediate modules are removed.

CPAN_MIRROR=http://mirrors.ustc.edu.cn/CPAN/
NO_TEST=--notest

# Test::*
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Test::Class Test::Roo Test::Taint Test::Without::Module

# Moose and Moo
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST MooX::Options MooseX::Getopt MooseX::Role::WithOverloading MooseX::Storage MooseX::Types::Path::Tiny

# CPAN
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::pmuninstall CPAN::Mini CPANDB Dist::Milla Module::Path Pod::POM::Web Search::Indexer

# Gtk3 stuffs
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3

# Database and WWW related
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST DBIx::Class::Helpers DBIx::XHTML_Table DBM::Deep MongoDB Mojolicious IO::All IO::All::LWP

# Develop
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Parallel::ForkManager Proc::Background Devel::CheckLib Import::Into

# text, rtf and xlsx
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Roman Text::Table Time::Duration Excel::Writer::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel RTF::Writer

# Math & Stat
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Math::Random::MT::Auto PDL Statistics::Lite Statistics::TTest Set::IntSpan::Fast Set::Light

# others
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Chart::Math::Axis List::Flatten PPI::XS

cpanm --mirror-only --mirror $CPAN_MIRROR --notest MooseX::AttributeHelpers

# with external lib
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Math::GSL Statistics::R

# AlignDB::*
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master $NO_TEST AlignDB::DeltaG AlignDB::GC
cpanm --mirror-only --mirror https://stratopan.com/wangq/alignDB/master $NO_TEST AlignDB::SQL AlignDB::ToXLSX

# DBD::mysql should be installed after brew install mysql51
