#------------------------------------------------------------------------------
package PYX::Filter;
#------------------------------------------------------------------------------
# $Id: Filter.pm,v 1.7 2005-08-26 19:35:28 skim Exp $
# Rules:
# - policy - accept, drop
# - accept
# - drop
#   - full_tag.
#   - end_tag.
#   - data.

# Pragmas.
use strict;

# Modules.
use Error::Simple;

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Rules.
	$self->{'rule'} = []; 

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." 
			if ! exists $self->{$key};
                $self->{$key} = $val;
        }

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'output_handler' => $self->{'output_handler'},
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
		'data' => \&_data,
		'instruction' => \&_instruction,
		'attribute' => \&_attribute,
		'comment' => \&_comment,
	);

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub add_rule {
#------------------------------------------------------------------------------
# Adding filter rule.

	my $self = shift;
}

#------------------------------------------------------------------------------
sub filter {
#------------------------------------------------------------------------------
# Filter output.

	my $self = shift;
	my $string = shift;
}

#------------------------------------------------------------------------------
sub get_rules {
#------------------------------------------------------------------------------
# Gets filtering rules.

	my $self = shift;
	return $self->{'rule'};
}

#------------------------------------------------------------------------------
# Internal functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start tag.
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end tag.
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comment.
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
}

1;
