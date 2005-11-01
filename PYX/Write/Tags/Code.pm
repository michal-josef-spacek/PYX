#------------------------------------------------------------------------------
package PYX::Write::Tags::Code;
#------------------------------------------------------------------------------
# $Id: Code.pm,v 1.9 2005-11-01 12:04:33 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple;
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw(@tag $tag_code);

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

	# Tag values.
	@tag = ();

	# Tag code.
	$tag_code = $self->{'tag_code'} = [];

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
sub get_tags_code {
#------------------------------------------------------------------------------
# Gets tags code.

	my $self = shift;
	return $self->{'tag_code'};
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
	push @{$tag_code}, 'end_'.$tag;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my $data = encode(shift);
	_flush_tag();
	push @{$tag_code}, \$data;
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
	# TODO Instruction by Tags.
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	if ($#tag > -1) {
		push @{$tag_code}, @tag;
		@tag = ();
	}
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comments.

	shift;
	my $comment = encode(shift);
	# TODO Comment by Tags.
}

1;
