#------------------------------------------------------------------------------
package PYX::Stack;
#------------------------------------------------------------------------------
# $Id: Stack.pm,v 1.3 2005-08-10 14:17:59 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
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
		croak "$class: Unknown parameter '$key'." 
			if ! exists $self->{$key};
		$self->{$key} = $val;
	}

	# If doesn't exist input file handler.
	croak "$class: Cannot exist input file handler ".
		"'$self->{'input_file_handler'}'."
		if $self->{'input_file_handler'} eq '';

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'output_handler' => $self->{'output_handler'},
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
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
	$self->{'pyx_parser'}->parse();
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
	if ($stack->[$#{$stack}] eq $tag) {
		pop @{$stack};
	}
	print $out join('/', @{$stack}), "\n" if $verbose && $#{$stack} > -1;
}

1;
