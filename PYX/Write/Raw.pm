#------------------------------------------------------------------------------
package PYX::Write::Raw;
#------------------------------------------------------------------------------
# $Id: Raw.pm,v 1.7 2005-07-03 12:59:04 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX::Parser;
use PYX::Utils;

# Global variables.
use vars qw(@tag $tag_open);

# Version.
our $VERSION = 0.1;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = {};
	bless $self, $class;

	# Input file handler.
	$self->{'input_file_handler'} = '';

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
	$self->{'pyx_parser'}->parse();
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
	my $data = PYX::Utils::encode(shift);
	_end_of_start_tag($pyx_parser_obj);
	print $out PYX::Utils::entity_encode($data);	
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	while (@_) {
		my ($att, $attval) = (shift @_, shift @_);
		print $out " $att=\"", PYX::Utils::entity_encode($attval), '"';
	}
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my ($target, $data) = @_;
	_end_of_start_tag($pyx_parser_obj);
	print $out "<?$target ", PYX::Utils::encode($data), "?>";
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
	print $out '<!--'.PYX::Utils::encode($comment).'-->';
}

1;
