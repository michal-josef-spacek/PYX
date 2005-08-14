#------------------------------------------------------------------------------
package PYX::Optimalization;
#------------------------------------------------------------------------------
# $Id: Optimalization.pm,v 1.4 2005-08-14 07:28:10 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX qw(char comment);
use PYX::Parser;
use PYX::Utils qw(encode decode);

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
		'output_rewrite' => 1,
		'data' => \&_data,
		'comment' => \&_comment,
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
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my $pyx_parser_obj = shift;
	my $data = shift;
	my $tmp = encode($data);
	if ($tmp =~ /^[\s\n]*$/) {
		return;
	}
	$tmp =~ s/^[\s\n]*//s;
	$tmp =~ s/[\s\n]*$//s;
	$data = decode($tmp);
	my $out = $pyx_parser_obj->{'output_handler'};
	print $out char($data), "\n";
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comment.

	my $pyx_parser_obj = shift;
	my $comment = shift;
	my $tmp = encode($comment);
	if ($tmp =~ /^[\s\n]*$/) {
		return;
	}
	$tmp =~ s/^[\s\n]*//s;
	$tmp =~ s/[\s\n]*$//s;
	$comment = decode($tmp);
	my $out = $pyx_parser_obj->{'output_handler'};
	print $out comment($comment), "\n";
}

1;
