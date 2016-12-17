#!/usr/bin/env bash

# This is a minimal set of modules, which means all intermediate modules are removed.

CPAN_MIRROR=http://mirrors.ustc.edu.cn/CPAN/
#CPAN_MIRROR=http://www.cpan.org/
NO_TEST=--notest

# Test::*
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Test::Class Test::Roo Test::Taint Test::Without::Module

# Moose and Moo
cpanm --mirror-only --mirror $CPAN_MIRROR --notest MooX::Options MooseX::Storage

# Develop
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::pmuninstall App::cpanoutdated CPAN::Mini CPANDB Dist::Milla Module::Path Pod::POM::Web Search::Indexer
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Parallel::ForkManager Proc::Background Devel::CheckLib Import::Into PPI::XS

# Gtk3 stuffs
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3

# Database and WWW
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST DBIx::Class::Helpers DBM::Deep MongoDB Mojolicious IO::All IO::All::LWP

# text, rtf and xlsx
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Roman Text::Table Time::Duration RTF::Writer Chart::Math::Axis
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Spreadsheet::XLSX Excel::Writer::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel

# Math and Stat
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Math::Random::MT::Auto PDL Math::GSL Statistics::R

# AlignDB::*
cpanm --mirror-only --mirror https://stratopan.com/wangq/ega/master $NO_TEST AlignDB::DeltaG AlignDB::GC AlignDB::ToXLSX AlignDB::Window AlignDB::Run

# DBD::mysql would be installed in `extra/7-mysql.sh`
