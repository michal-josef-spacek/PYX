#------------------------------------------------------------------------------
package PYX::Parser;
#------------------------------------------------------------------------------
# $Id: Parser.pm,v 1.23 2005-08-26 19:35:28 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use Error::Simple;

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
	$self->{'attribute'} = '';
	$self->{'comment'} = '';
	$self->{'data'} = '';
	$self->{'end_tag'} = '';
	$self->{'final'} = '';
	$self->{'init'} = '';
	$self->{'instruction'} = '';
	$self->{'start_tag'} = '';
	$self->{'other'} = '';

	# Output rewrite.
	$self->{'output_rewrite'} = 0;

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." 
			if ! exists $self->{$key};
                $self->{$key} = $val;
        }

	# Warning about handlers.
	if (! $self->{'start_tag'} 
		&& ! $self->{'attribute'}
		&& ! $self->{'comment'}
		&& ! $self->{'data'}
		&& ! $self->{'end_tag'}
		&& ! $self->{'final'}
		&& ! $self->{'init'}
		&& ! $self->{'instruction'}
		&& ! $self->{'other'}
		&& ! $self->{'rewrite'}) {

		carp "$class: Cannot defined handlers.";
	}

	# If doesn't exist input file handler.
	err "Cannot exist input file handler ".
		"'$self->{'input_file_handler'}'."
		if $self->{'input_file_handler'} eq '';

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
	if ($self->{'init'}) {
		&{$self->{'init'}}($self);
	}
	while (my $line = <$tmp>) {
		chomp $line;
		$self->{'line'} = $line;
		my ($type, $value) = $line =~ m/\A([A()\?\-_])(.*)\Z/;
		if (! $type) { $type = 'X'; }

		# Attribute.
		if ($type eq 'A') {
			my ($att, $attval) = $line =~ m/\AA([^\s]+)\s*(.*)\Z/;
#			if ($self->{'attribute'}) {
#				&{$self->{'attribute'}}($self, $att, $attval);
#			} elsif ($self->{'output_rewrite'}) {
#				print $out $line, "\n";
#			}
			$self->_is_sub('attribute', $out, $att, $attval);

		# Start of tag.
		} elsif ($type eq '(') {
#			if ($self->{'start_tag'}) {
#				&{$self->{'start_tag'}}($self, $value);
#			} elsif ($self->{'output_rewrite'}) {
#				print $out $line, "\n";
#			}
			$self->_is_sub('start_tag', $out, $value);

		# End of tag.
		} elsif ($type eq ')') {
#			if ($self->{'end_tag'}) {
#				&{$self->{'end_tag'}}($self, $value);
#			} elsif ($self->{'output_rewrite'}) {
#				print $out $line, "\n";
#			}
			$self->_is_sub('end_tag', $out, $value);

		# Data.
		} elsif ($type eq '-') {
#			if ($self->{'data'}) {
#				&{$self->{'data'}}($self, $value);
#			} elsif ($self->{'output_rewrite'}) {
#				print $out $line, "\n";
#			}
			$self->_is_sub('data', $out, $value);

		# Instruction.
		} elsif ($type eq '?') {
			my ($target, $data) = $line =~ m/\A\?([^\s]+)\s*(.*)\Z/;
#			if ($self->{'instruction'}) {
#				&{$self->{'instruction'}}($self, $target, 
#					$data);
#			} elsif ($self->{'output_rewrite'}) {
#				print $out $line, "\n";
#			}
			$self->_is_sub('instruction', $out, $target, $data);

		# Comment.
		} elsif ($type eq '_') {
#			if ($self->{'comment'}) {
#				&{$self->{'comment'}}($self, $value);
#			} elsif ($self->{'output_rewrite'}) {
#				print $out $line, "\n";
#			}
			$self->_is_sub('comment', $out, $value);

		# Others.
		} else {
			if ($self->{'other'}) {
				&{$self->{'other'}}($self, $line);
			} else {
				err "Bad PYX tag at line '$line'.";
			}
		}
	}
	if ($self->{'final'}) {
		&{$self->{'final'}}($self);
	}
}

#------------------------------------------------------------------------------
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _is_sub {
#------------------------------------------------------------------------------
# Helper to defined handlers.

	my ($self, $key, $out, @values) = @_;

	# Handler with name '$key'.
	if (exists $self->{$key} && ref $self->{$key} eq 'CODE') {
		&{$self->{$key}}($self, @values);

	# Handler rewrite.
	} elsif (exists $self->{'rewrite'} 
		&& ref $self->{'rewrite'} eq 'CODE') {

		&{$self->{'rewrite'}}($self, $self->{'line'});

	# Raw output to output handler handler.
	} elsif ($self->{'output_rewrite'}) {
		print $out $self->{'line'}, "\n";
	}
}

1;
