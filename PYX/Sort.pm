#------------------------------------------------------------------------------
package PYX::Sort;
#------------------------------------------------------------------------------
# $Id: Sort.pm,v 1.8 2005-08-14 07:03:11 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX::Parser;

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($tag);

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
		'attribute' => \&_attribute,
		'start_tag' => \&_tag,
		'end_tag' => \&_tag,
		'comment' => \&_tag,
		'instruction' => \&_tag,
		'data' => \&_tag,
	);

	# Tag values.
	$tag = {};

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
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my ($att, $attval) = (shift, shift);
	$tag->{$att} = $attval;
}

#------------------------------------------------------------------------------
sub _tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	_flush($pyx_parser_obj);
	print $out $pyx_parser_obj->{'line'}, "\n";
}

#------------------------------------------------------------------------------
sub _flush {
#------------------------------------------------------------------------------
# Flush attributes.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if (scalar %{$tag}) {
		foreach my $key (sort keys %{$tag}) {
			print $out 'A'.$key.'="'.$tag->{$key}.'"'."\n";
		}
		$tag = {};
	}
}

1;
