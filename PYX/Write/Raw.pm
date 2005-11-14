#------------------------------------------------------------------------------
package PYX::Write::Raw;
#------------------------------------------------------------------------------
# $Id: Raw.pm,v 1.14 2005-11-14 15:55:14 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
use PYX::Parser;
use PYX::Utils qw(encode entity_encode);

# Global variables.
use vars qw(@tag $tag_open);

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

	# Open tag.
	$self->{'tag_open'} = 0;
	$tag_open = \$self->{'tag_open'};

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
# Internal functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $tag = shift;
	_end_of_start_tag($pyx_parser_obj);
	print $out "<$tag";
	${$tag_open} = 1;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $tag = shift;
	_end_of_start_tag($pyx_parser_obj);
	print $out "</$tag>";
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $data = encode(shift);
	_end_of_start_tag($pyx_parser_obj);
	print $out entity_encode($data);	
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my ($att, $attval) = (shift, shift);
	print $out " $att=\"", entity_encode($attval), '"';
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my ($target, $data) = @_;
	_end_of_start_tag($pyx_parser_obj);
	print $out "<?$target ", encode($data), "?>";
}

#------------------------------------------------------------------------------
sub _end_of_start_tag {
#------------------------------------------------------------------------------
# Ends start tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if (${$tag_open}) {
		print $out '>';
		${$tag_open} = 0;
	}
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comment.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $comment = shift;
	print $out '<!--'.encode($comment).'-->';
}

1;
