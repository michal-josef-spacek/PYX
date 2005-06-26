#------------------------------------------------------------------------------
package PYX::Parser;
#------------------------------------------------------------------------------
# $Id: Parser.pm,v 1.2 2005-06-26 12:20:20 skim Exp $

# Version.
our $VERSION = 0.1;

# Modules.
use Carp;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = {};
	bless $self, $class;

	# Input file handler.
	$self->{'input_file_handler'} = '';

	# Parse handlers.
	$self->{'start_tag'} = '';
	$self->{'attribute'} = '';
	$self->{'end_tag'} = '';
	$self->{'special_tag'} = '';
	$self->{'data'} = '';
	$self->{'comment'} = '';

	# Process params.
	croak "$class: Created with odd number of parameters - should be ".
		"of the form option => value." if (@_ % 2);
	for (my $x = 0; $x <= $#_; $x += 2) {
		if (exists $self->{$_[$x]}) {
			$self->{$_[$x]} = $_[$x+1];
		} else {
			croak "$class: Bad parameter '$_[$x]'.";
		}
	}

	# Warning about handlers.
	if (! $self->{'start_tag'} 
		&& ! $self->{'attribute'}
		&& ! $self->{'end_tag'}
		&& ! $self->{'special_tag'}
		&& ! $self->{'data'}
		&& ! $self->{'comment'}) {

		carp "$class: Cannot defined handlers.";
	}

	# If doesn't exist input file handler.
	croak "$class: Cannot exist input file handler ".
		"'$self->{'input_file_handler'}'."
		if $self->{'input_file_handler'} eq '';

	# Class.
	$self->{'class'} = $class;

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx format.

	my $self = shift;
	my $tmp = $self->{'input_file_handler'};
	while (my $line = <$tmp>) {
		chomp $line;
		my ($type, $value) = $line =~ m/\A([A()?-])(.*)\Z/;

		# Attribute.
		if ($type eq 'A') {
			my ($att, $attval) = $line =~ m/\AA([^\s]+)\s*(.*)\Z/;
			&{$self->{'attribute'}}($att, $attval)
				if $self->{'attribute'};
		}

		# Start of tag.
		if ($type eq '(') {
			&{$self->{'start_tag'}}($value)
				if $self->{'start_tag'};
			$tag_open = 1;

		# End of tag.
		} elsif ($type eq ')') {
			&{$self->{'end_tag'}}($value)
				if $self->{'end_tag'};

		# Data.
		} elsif ($type eq '-') {
			&{$self->{'data'}}($value)
				if $self->{'data'};		

		# Special tag.
		} elsif ($type eq '?') {
			&{$self->{'special_tag'}}($value)
				if $self->{'special_tag'};

		# Comment.
		} elsif ($type eq 'C') {
			&{$self->{'comment'}}($value)
				if $self->{'comment'};
		}
	}
}

1;
