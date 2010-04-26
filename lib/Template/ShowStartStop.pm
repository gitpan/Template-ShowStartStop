package Template::ShowStartStop;

use warnings;
use strict;

=head1 NAME

Template::ShowStartStop - Display where template's start and stop

=head1 VERSION

Version 0.05

=cut

our $VERSION = '0.05';

use parent qw( Template::Context );

my $sub = qw(process);

my $super = __PACKAGE__->can("SUPER::$sub") or die;

my $wrapped = sub {
	my $self = shift;
	my $what = shift;

	my $template
		# conditional           # set $template to
		= ref($what) eq 'ARRAY' ? join( ' + ', @{$what} )
		: ref($what)            ? $what->name
		:                         $what
		;

	my $processed_data = $super->($self, $what, @_);

	my $output
		= "<!-- START: $sub $template -->\n"
		. "$processed_data"
		. "<!-- STOP:  $sub $template -->\n"
		;

	return $output;
};

{ no strict 'refs'; *{$sub} = $wrapped; }

1;
__END__

=head1 SYNOPSIS

Template::ShowStartStop provides inline comments througout your code where
each template stops and starts.  It's an overridden version of L<Template::Context>
that wraps the C<process()> method.

Using Template::ShowStartStop is simple.

	use Template::ShowStartStop;

	my %config = ( # Whatever your config is
		INCLUDE_PATH	=> '/my/template/path',
		COMPILE_EXT	 => '.ttc',
		COMPILE_DIR	 => '/tmp/tt',
	);

	if ( $development_mode ) {
		$config{ CONTEXT } = Template::ShowStartStop->new( %config );
	}

	my $template = Template->new( \%config );

Now when you process templates, HTML comments will get embedded in your
output, which you can easily grep for.  The nesting level is also shown.

	<!-- START: include mainmenu/cssindex.tt -->
	<!-- STOP:  include mainmenu/cssindex.tt -->

	....

	<!-- STOP:  include mainmenu/footer.tt -->

=head1 AUTHOR

Caleb Cushing, C<< <xenoterracide@gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests on 
L<http://github.com/xenoterracide/Template-ShowStartStop/issues>
as I'm not fond of RT.

=head1 ACKNOWLEDGEMENTS

Thanks to
Andy Lester,
Randal Schwartz,
Bill Moseley,
and to Gavin Estey for the original Template::Timer code that this is based on.

=head1 COPYRIGHT & LICENSE

This library is free software; you can redistribute it and/or modify
it under the terms of either the GNU Public License v3, or the Artistic
License 2.0.

	* http://www.gnu.org/copyleft/gpl.html

	* http://www.opensource.org/licenses/artistic-license-2.0.php

=cut
# notes from an IRC conversation on how to improve this module
[Tuesday 02 March 2010] [04:26:51 pm] <tm604>   xenoterracide: you can get rid
of foreach, since you only wrap one method, also drop my $super = ...;, remove
'no strict', change '*{$sub} = sub {' for 'my $wrappedSub = sub {', use 'my
$processed_data = $self->SUPER::process(...)', and at the end put { no strict
'refs'; *{'process'} = $wrappedSub; }.
[Tuesday 02 March 2010] [04:32:10 pm] <xenoterracide>   tm604 would I still
need the foreach if I was still wrapping include?
[Tuesday 02 March 2010] [04:32:31 pm] <tm604>   xenoterracide: Not really,
because it's needless complexity for something that's just subclassing one or
two methods.
[Tuesday 02 March 2010] [04:32:49 pm] <xenoterracide>   k
[Tuesday 02 March 2010] [04:35:08 pm] <tm604>   xenoterracide: Just put the
common code in a single sub, and have it call include or process as
appropriate.