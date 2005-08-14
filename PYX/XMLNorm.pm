#------------------------------------------------------------------------------
package PYX::XMLNorm;
#------------------------------------------------------------------------------
# $Id: XMLNorm.pm,v 1.3 2005-08-14 08:33:37 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX qw(end_tag);
use PYX::Parser;

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($stack $rules);

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

	# XML normalization rules.
	$self->{'rules'} = {};

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

	# Check to rules.
	croak "$class: Cannot exist XML normalization rules."
		if keys %{$self->{'rules'}} == 0;

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'output_handler' => $self->{'output_handler'},
		'output_rewrite' => 1,
		'end_tag' => \&_end_tag,
		'final' => \&_final,
		'start_tag' => \&_start_tag,
	);

	# Tag values.
	$stack = [];

	# Rules.
	$rules = $self->{'rules'};

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
# Process start of tag.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	my $tag = shift;
	if (exists $rules->{$tag}) {
		foreach my $tmp (@{$rules->{$tag}}) {
			if ($stack->[$#{$stack}] eq $tmp) {
				print $out end_tag($tmp), "\n";
			}
		}	
	}
	if (exists $rules->{'*'}) {
		foreach my $tmp (@{$rules->{'*'}}) {
			if ($stack->[$#{$stack}] eq $tmp) {
				print $out end_tag($tmp), "\n";
			}
		}	
	}
	push @{$stack}, $tag;	
	print $out $pyx_parser->{'line'}, "\n";
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	my $tag = shift;
	if (exists $rules->{$tag}) {
		foreach my $tmp (@{$rules->{$tag}}) {
			if ($stack->[$#{$stack}] eq $tmp) {
				print $out end_tag($tmp), "\n";
			}
		}	
	}
	if ($stack->[$#{$stack}] eq $tag) {
		pop @{$stack};
	}
	print $out $pyx_parser->{'line'}, "\n";
}

#------------------------------------------------------------------------------
sub _final {
#------------------------------------------------------------------------------
# Process final.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	if (exists $rules->{'*'}) {
		foreach my $tmp (@{$rules->{'*'}}) {
			if ($stack->[$#{$stack}] eq $tmp) {
				print $out end_tag($tmp), "\n";
			}
		}	
	}
}

1;
