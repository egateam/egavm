#!/usr/bin/env bash

# Test::*
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Test::Base Test::Class Test::CleanNamespaces Test::LeakTrace Test::Number::Delta Test::Roo Test::Taint Test::Warnings Test::Without::Module

# Moose and Moo
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ MooX::Options MooseX::Getopt MooseX::Role::WithOverloading MooseX::Storage MooseX::Types::Path::Tiny Type::Tiny

# CPAN
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ App::pmuninstall CPAN::Mini CPANDB Dist::Zilla::Plugin::Git Dist::Zilla::Plugin::PerlTidy Dist::Zilla::Plugin::PodWeaver Module::Path Pod::POM::Web

# Gtk3 stuffs
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Font::TTF Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3

# Database related
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ DBIx::Class::Helpers DBIx::XHTML_Table DBM::Deep MongoDB

# Net and WWW
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Growl::GNTP HTTP::Cookies HTTP::Negotiate WWW::RobotRules Mojolicious Authen::SASL::SASLprep

# Develop
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ AppConfig Config::AutoConf File::ConfigDir EV AnyEvent Parallel::ForkManager Proc::Background Crypt::URandom Devel::CheckBin Devel::CheckLib Devel::SimpleTrace Import::Into Safe::Isa Sub::Identify

# text, rtf and xlsx
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Roman Text::Table Time::Duration Data::Table Data::Table::Excel Excel::Writer::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel RTF::Writer

# Math & Stat
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Math::Combinatorics Math::GSL Math::Random::MT::Auto PDL Statistics::Lite Statistics::R Scalar::Util::Numeric Set::IntSpan::Fast Set::Light

# others
cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ Geo::Proj4 Chart::Math::Axis Graphics::ColorUtils List::Flatten Memoize PPI::XS Path::Iterator::Rule PkgConfig Syntax::Keyword::Junction Term::Encoding YAML::LibYAML

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest MooseX::AttributeHelpers

# cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --look DBD::mysql
