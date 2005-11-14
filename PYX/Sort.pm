#------------------------------------------------------------------------------
package PYX::Sort;
#------------------------------------------------------------------------------
# $Id: Sort.pm,v 1.12 2005-11-14 17:04:47 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
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
		err "Unknown parameter '$key'." if ! exists $self->{$key};
		$self->{$key} = $val;
	}

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
