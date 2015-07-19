#!/usr/bin/env bash

# This is a minimal set of modules, which means all intermediate modules are removed.

CPAN_MIRROR=http://mirrors.ustc.edu.cn/CPAN/

# Test::*
cpanm --mirror-only --mirror $CPAN_MIRROR Test::Class Test::Roo Test::Taint Test::Without::Module

# Moose and Moo
cpanm --mirror-only --mirror $CPAN_MIRROR MooX::Options MooseX::Getopt MooseX::Role::WithOverloading MooseX::Storage MooseX::Types::Path::Tiny

# CPAN
cpanm --mirror-only --mirror $CPAN_MIRROR App::pmuninstall CPAN::Mini CPANDB Dist::Zilla::Plugin::Git Dist::Zilla::Plugin::PerlTidy Dist::Zilla::Plugin::PodWeaver Module::Path Pod::POM::Web

# Gtk3 stuffs
cpanm --mirror-only --mirror $CPAN_MIRROR Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3

# Database and WWW related
cpanm --mirror-only --mirror $CPAN_MIRROR DBIx::Class::Helpers DBIx::XHTML_Table DBM::Deep MongoDB Mojolicious

# Develop
cpanm --mirror-only --mirror $CPAN_MIRROR Parallel::ForkManager Proc::Background Devel::CheckLib Import::Into

# text, rtf and xlsx
cpanm --mirror-only --mirror $CPAN_MIRROR Roman Text::Table Time::Duration Excel::Writer::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel RTF::Writer

# Math & Stat
cpanm --mirror-only --mirror $CPAN_MIRROR Math::Random::MT::Auto PDL Statistics::Lite Statistics::TTest Set::IntSpan::Fast Set::Light

# others
cpanm --mirror-only --mirror $CPAN_MIRROR Chart::Math::Axis List::Flatten PPI::XS

cpanm --mirror-only --mirror $CPAN_MIRROR --notest MooseX::AttributeHelpers

# with external lib
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Math::GSL Statistics::R

# DBD::mysql installed after brew mysql51
