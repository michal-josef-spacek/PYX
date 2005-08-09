#------------------------------------------------------------------------------
package PYX::Write::Tags2;
#------------------------------------------------------------------------------
# $Id: Tags2.pm,v 1.3 2005-08-09 07:59:10 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($tags @tag);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Tags object.
	$self->{'tags_obj'} = '';

	# Input file handler.
	$self->{'input_file_handler'} = '';

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                croak "Bad parameter '$key'." if ! exists $self->{$key};
                $self->{$key} = $val;
        }

	# If doesn't exist Tags object.
	unless ($self->{'tags_obj'} && ($self->{'tags_obj'}->isa('Tags2'))) {

		croak "$class: Bad 'Tags2' object '$self->{'tags_obj'}'.";
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

	# Tags object.
	$tags = $self->{'tags_obj'};

	# Tag values.
	@tag = ();

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Start of parsing.

	my $self = shift;
	$self->{'pyx_parser'}->parse();
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	shift;
	$tags->put(['b', shift]);
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	shift;
	$tags->put(['e', shift]);
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my @data = @_;
	$tags->put(['d', map(encode($_), @data)]);
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	$tags->put(['a', @_]);
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction tag.

	shift;
	$tags->put(['i', @_]);
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comments.

	shift;
	$tags->put(['c', encode(shift)]);
}

1;
