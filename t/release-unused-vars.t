#!perl
#
# This file is part of Template-ShowStartStop
#
# This software is Copyright (c) 2010 by Caleb Cushing.
#
# This is free software, licensed under:
#
#   The Artistic License 2.0
#
use strict;
use warnings;

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}


use Test::More;

eval "use Test::Vars";
plan skip_all => "Test::Vars required for testing unused vars"
  if $@;
all_vars_ok();
