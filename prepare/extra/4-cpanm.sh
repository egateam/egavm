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
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::pmuninstall App::cpanoutdated CPANDB Minilla Module::Path
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Pod::POM::Web Search::Indexer PPI::XS
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Parallel::ForkManager Proc::Background Devel::CheckLib Import::Into

# Gtk3 stuffs
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3

# Math
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Math::Random::MT::Auto PDL Math::GSL

# Statistics::R would be installed in `7-brew.sh`
# DBD::mysql would be installed in `extra/7-mysql.sh`
