#------------------------------------------------------------------------------
package PYX::Parser;
#------------------------------------------------------------------------------
# $Id: Parser.pm,v 1.18 2005-08-13 14:18:15 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;

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

	# Parse handlers.
	$self->{'start_tag'} = '';
	$self->{'attribute'} = '';
	$self->{'end_tag'} = '';
	$self->{'instruction'} = '';
	$self->{'data'} = '';
	$self->{'comment'} = '';
	$self->{'other'} = '';

	# Output rewrite.
	$self->{'output_rewrite'} = 0;

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

	# Warning about handlers.
	if (! $self->{'start_tag'} 
		&& ! $self->{'attribute'}
		&& ! $self->{'end_tag'}
		&& ! $self->{'instruction'}
		&& ! $self->{'data'}
		&& ! $self->{'comment'}
		&& ! $self->{'other'}) {

		carp "$class: Cannot defined handlers.";
	}

	# If doesn't exist input file handler.
	croak "$class: Cannot exist input file handler ".
		"'$self->{'input_file_handler'}'."
		if $self->{'input_file_handler'} eq '';

	# Class.
	$self->{'class'} = $class;

	# Processing line.
	$self->{'line'} = '';

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx format.

	my $self = shift;
	my $tmp = $self->{'input_file_handler'};
	my $out = shift || $self->{'output_handler'};
	while (my $line = <$tmp>) {
		chomp $line;
		$self->{'line'} = $line;
		my ($type, $value) = $line =~ m/\A([A()\?\-_])(.*)\Z/;
		if (! $type) { $type = 'X'; }

		# Attribute.
		if ($type eq 'A') {
			my ($att, $attval) = $line =~ m/\AA([^\s]+)\s*(.*)\Z/;
			if ($self->{'attribute'}) {
				&{$self->{'attribute'}}($self, $att, $attval);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}

		# Start of tag.
		} elsif ($type eq '(') {
			if ($self->{'start_tag'}) {
				&{$self->{'start_tag'}}($self, $value);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}

		# End of tag.
		} elsif ($type eq ')') {
			if ($self->{'end_tag'}) {
				&{$self->{'end_tag'}}($self, $value);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}

		# Data.
		} elsif ($type eq '-') {
			if ($self->{'data'}) {
				&{$self->{'data'}}($self, $value);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}

		# Instruction.
		} elsif ($type eq '?') {
			my ($target, $data) = $line =~ m/\A\?([^\s]+)\s*(.*)\Z/;
			if ($self->{'instruction'}) {
				&{$self->{'instruction'}}($self, $target, 
					$data);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}

		# Comment.
		} elsif ($type eq 'C') {
			if ($self->{'comment'}) {
				&{$self->{'comment'}}($self, $value);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}

		# Others.
		} else {
			if ($self->{'other'}) {
				&{$self->{'other'}}($self, $line);
			} else {
				croak "$self->{'class'}: Bad PYX tag at ".
					"line '$line'.";
			}
		}
	}
}

1;
