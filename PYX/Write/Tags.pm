#------------------------------------------------------------------------------
package PYX::Write::Tags;
#------------------------------------------------------------------------------
# $Id: Tags.pm,v 1.17 2005-11-14 15:50:08 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple;
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

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." unless exists $self->{$key};
                $self->{$key} = $val;
        }

	# If doesn't exist Tags object.
	unless ($self->{'tags_obj'} && ($self->{'tags_obj'}->isa('Tags')
		|| $self->{'tags_obj'}->isa('Tags::Running'))) {

		err "Bad 'Tags' object '$self->{'tags_obj'}'.";
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
	$self->{'pyx_parser'}->parse;
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	shift;
	my $tag = shift;
	_flush_tag();
	push @tag, $tag;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	shift;
	my $tag = shift;
	_flush_tag();
	$tags->print(['end_'.$tag]);
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my $data = encode(shift);
	_flush_tag();
	$tags->print([\$data]);
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	if (ref $tag[-1] ne 'ARRAY') {
		push @tag, [];
	}
	push @{$tag[-1]}, @_;
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction tag.

	shift;
	my ($target, $data) = @_;
	# XXX Doesn't support.
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	if ($#tag > -1) {
		$tags->print([@tag]);
		@tag = ();
	}
}

1;
