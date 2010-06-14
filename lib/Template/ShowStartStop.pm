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
package Template::ShowStartStop;
BEGIN {
  $Template::ShowStartStop::VERSION = '0.12';
}
use Moose;
use namespace::autoclean;

extends 'Template::Context';
with 'MooseX::Template::Context::Role::ShowStartStop';

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
# ABSTRACT: Display where templates start and stop

__END__
=pod

=head1 NAME

Template::ShowStartStop - Display where templates start and stop

=head1 VERSION

version 0.12

=head1 SYNOPSIS

	use Template::ShowStartStop;

	my $tt = Template->new({
		CONTEXT => Template::ShowStartStop->new
	});

=head1 DESCRIPTION

Template::ShowStartStop provides inline comments throughout your code where
each template stops and starts.  It's an overridden version of L<Template::Context>
that wraps the C<process()> method.

Using Template::ShowStartStop is simple.
Now when you process templates, HTML comments will get embedded in your
output, which you can easily grep for.  The nesting level is also shown.

	<!-- START: process wrapper.tt -->
	<!DOCTYPE html>
	<html>
	<head>
	<!-- START: process head.tt -->
	...
	<!-- STOP:  process head.tt -->
	</head>
	...
	</html>
	<!-- STOP:  process wrapper.tt -->

=head1 BUGS

Please report any bugs or feature requests on
L<http://github.com/xenoterracide/Template-ShowStartStop/issues>
as I'm not fond of RT.

=head1 SUBMITTING PATCHES

Please read the SubmittingPatches file included with this Distribution. Patches
that are of sufficient quality, within the goals of the project and pass the
checklist will probably be accepted.

=head1 ACKNOWLEDGEMENTS

Thanks to
Andy Lester,
Randal Schwartz,
Bill Moseley,
and to Gavin Estey for the original Template::Timer code that this is based on.

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0

=cut

