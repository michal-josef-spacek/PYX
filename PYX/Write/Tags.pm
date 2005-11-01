#------------------------------------------------------------------------------
package PYX::Write::Tags;
#------------------------------------------------------------------------------
# $Id: Tags.pm,v 1.16 2005-11-01 12:04:30 skim Exp $

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

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." if ! exists $self->{$key};
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

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $tag = shift;
	_flush_tag($pyx_parser_obj);
	push @tag, $tag;
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
	my $data = encode(shift);
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

1;
