#------------------------------------------------------------------------------
package PYX::Get;
#------------------------------------------------------------------------------
# $Id: Get.pm,v 1.3 2005-11-01 12:20:49 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple;
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

	# Rules.
	$self->{'rules'} = [];

	# Verbose.
	$self->{'verbose'} = 0;

	# Process params.
	while (@_) {
		my $key = shift;
		my $val = shift;
		err "Unknown parameter '$key'." if ! exists $self->{$key};
		$self->{$key} = $val;
	}

	# If doesn't exist input file handler.
	err "Cannot exist input file handler ".
		"'$self->{'input_file_handler'}'."
		if $self->{'input_file_handler'} eq '';

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'output_handler' => $self->{'output_handler'},
		'end_tag' => \&_end_tag,
		'start_tag' => \&_start_tag,
		'data' => \&_data,
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
# Start of parsing.

	my $self = shift;
	$self->{'pyx_parser'}->parse;
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

#------------------------------------------------------------------------------
sub _other {
#------------------------------------------------------------------------------
# Process other.
}

1;
