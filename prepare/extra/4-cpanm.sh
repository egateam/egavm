#!/usr/bin/env bash

# This is a minimal set of modules, which means all intermediate modules are removed.

# Test::*
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Test::Class Test::Roo Test::Taint Test::Without::Module

# Moose and Moo
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ MooX::Options MooseX::Getopt MooseX::Role::WithOverloading MooseX::Storage MooseX::Types::Path::Tiny

# CPAN
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ App::pmuninstall CPAN::Mini CPANDB Dist::Zilla::Plugin::Git Dist::Zilla::Plugin::PerlTidy Dist::Zilla::Plugin::PodWeaver Module::Path Pod::POM::Web

# Gtk3 stuffs
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3

# Database and WWW related
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ DBIx::Class::Helpers DBIx::XHTML_Table DBM::Deep MongoDB Mojolicious

# Develop
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Parallel::ForkManager Proc::Background Devel::CheckLib Import::Into

# text, rtf and xlsx
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Roman Text::Table Time::Duration Data::Table Data::Table::Excel Excel::Writer::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel RTF::Writer

# Math & Stat
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Math::Random::MT::Auto PDL Statistics::Lite Set::IntSpan::Fast Set::Light

# others
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Chart::Math::Axis List::Flatten PPI::XS

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest MooseX::AttributeHelpers

# with external lib
# cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Math::GSL Statistics::R Geo::Proj4
# cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --look DBD::mysql
