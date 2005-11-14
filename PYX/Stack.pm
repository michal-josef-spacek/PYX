#------------------------------------------------------------------------------
package PYX::Stack;
#------------------------------------------------------------------------------
# $Id: Stack.pm,v 1.10 2005-11-14 17:04:47 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
use PYX::Parser;

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($stack $verbose);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Input file handler.
	$self->{'input_file_handler'} = '';

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Verbose.
	$self->{'verbose'} = 0;

	# Process params.
	while (@_) {
		my $key = shift;
		my $val = shift;
		err "Unknown parameter '$key'." unless exists $self->{$key};
		$self->{$key} = $val;
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'output_handler' => $self->{'output_handler'},
		'end_tag' => \&_end_tag,
		'start_tag' => \&_start_tag,
	);

	# Tag values.
	$stack = [];

	# Verbose.
	$verbose = $self->{'verbose'};

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse text.

	my $self = shift;
	my $pyx_array_ref = shift;
	my $out = shift || $self->{'output_handler'};
	$self->{'pyx_parser'}->parse($pyx_array_ref, $out);
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.

	my $self = shift;
	my $tmp = shift || $self->{'input_file_handler'};
	my $out = shift || $self->{'output_handler'};
	$self->{'pyx_parser'}->parse_handler($tmp, $out);
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser_obj = shift;
	my $tag = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	push @{$stack}, $tag;
	print $out join('/', @{$stack}), "\n" if $verbose;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser_obj = shift;
	my $tag = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if ($stack->[-1] eq $tag) {
		pop @{$stack};
	}
	print $out join('/', @{$stack}), "\n" if $verbose && $#{$stack} > -1;
}

1;
