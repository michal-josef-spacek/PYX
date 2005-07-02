#------------------------------------------------------------------------------
package PYX::Parser;
#------------------------------------------------------------------------------
# $Id: Parser.pm,v 1.4 2005-07-02 13:29:31 skim Exp $

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
	$self->{'instruction'} = '';
	$self->{'data'} = '';
	$self->{'comment'} = '';

	# Output rewrite.
	$self->{'output_rewrite'} = 0;

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

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
		&& ! $self->{'instruction'}
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
		my ($type, $value) = $line =~ m/\A([A()\?\-C])(.*)\Z/;

		# Attribute.
		if ($type eq 'A') {
			my ($att, $attval) = $line =~ m/\AA([^\s]+)\s*(.*)\Z/;
			if ($self->{'attribute'}) {
				&{$self->{'attribute'}}($self, $att, $attval);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}
		}

		# Start of tag.
		if ($type eq '(') {
			if ($self->{'start_tag'}) {
				&{$self->{'start_tag'}}($self, $value);
			} elsif ($self->{'output_rewrite'}) {
				print $out $line, "\n";
			}
			$tag_open = 1;

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

		# Special tag.
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
		}
	}
}

#------------------------------------------------------------------------------
sub get_line {
#------------------------------------------------------------------------------
# Get line.

	my $self = shift;
	my $out = shift || $self->{'output_handler'};
	print $out $self->{'line'}, "\n";
}

1;
