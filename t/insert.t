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
use strict;
use warnings;
use Template::ShowStartStop;
use Template::Test;

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new,
});

my $vars = {
	var => 'world',
};

test_expect(\*DATA, $tt, $vars);

__DATA__
--test--
hello [% var %]
[% INSERT t/templates/how.tt -%]
--expect--
<!-- START: process input text -->
hello world
How are you today?
<!-- STOP:  process input text -->