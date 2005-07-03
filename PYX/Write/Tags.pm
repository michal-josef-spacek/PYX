#------------------------------------------------------------------------------
package PYX::Write::Tags;
#------------------------------------------------------------------------------
# $Id: Tags.pm,v 1.7 2005-07-03 12:59:04 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;
use PYX::Parser;
use PYX::Utils;

# Version.
our $VERSION = 0.1;

# Global variables.
use vars qw($tags @tag);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = {};
	bless $self, $class;

	# Tags object.
	$self->{'tags_obj'} = '';

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

	# If doesn't exist Tags object.
	unless ($self->{'tags_obj'} && ($self->{'tags_obj'}->isa('Tags')
		|| $self->{'tags_obj'}->isa('Tags::Running'))) {

		croak "$class: Bad 'Tags' object '$self->{'tags_obj'}'.";
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

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $tag = shift;
	_flush_tag($pyx_parser_obj);
	push @tag, $tag, [];
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $tag = shift;
	_flush_tag($pyx_parser_obj);
	if ($tags->{'output_handler'}) {
		$tags->print(['end_'.$tag]);
	} else {
		my $ret = $tags->print(['end_'.$tag]);
		print $out $ret;
	}
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $data = PYX::Utils::encode(shift);
	_flush_tag($pyx_parser_obj);
	if ($tags->{'output_handler'}) {
		$tags->print([\$data]);
	} else {
		my $ret = $tags->print([\$data]);
		print $out $ret;
	}
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	push @{$tag[$#tag]}, @_;
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction tag.

	shift;
	my ($target, $data) = @_;
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if ($#tag > -1) {
		if ($tags->{'output_handler'}) {
			$tags->print([@tag]);
		} else {
			my $ret = $tags->print([@tag]);
			print $out $ret;
		}
		@tag = ();
	}
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comments.

	shift;
	my $comment = PYX::Utils::encode(shift);
	# TODO Comment by Tags.
}

1;
