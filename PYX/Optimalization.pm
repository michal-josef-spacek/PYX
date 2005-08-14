#------------------------------------------------------------------------------
package PYX::Optimalization;
#------------------------------------------------------------------------------
# $Id: Optimalization.pm,v 1.1 2005-08-14 07:03:02 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX::Parser;
use PYX qw(char comment);

# Version.
our $VERSION = 0.01;

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
		'char' => \&_char,
		'comment' => \&_comment,
		'default' => \&_char,
	);

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
sub _char {
#------------------------------------------------------------------------------
# Process character and default.

	my $pyx_parser_obj = shift;
	my $data = shift;
	if ($data =~ /^[\s\n]*$/) {
		return;
	}
	$data =~ s/^[\s\n]*//;
	$data =~ s/[\s\n]*$//;
	my $out = $pyx_parser_obj->{'output_handler'};
	print $out char($data);
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comment.

	my $pyx_parser_obj = shift;
	my $comment = shift;
	if ($comment =~ /^[\s\n]*$/) {
		return;
	}
	my $out = $pyx_parser_obj->{'output_handler'};
	print $out comment($comment);
}

1;
