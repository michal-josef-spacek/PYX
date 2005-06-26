#------------------------------------------------------------------------------
package PYX::Write::Tags;
#------------------------------------------------------------------------------
# $Id: Tags.pm,v 1.3 2005-06-26 09:58:53 skim Exp $

# Version.
our $VERSION = 0.1;

# Modules.
use Carp;
use PYX::Parser;
use PYX::Utils;

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
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
		'data' => \&_data,
		'special_tag' => \&_special_tag,
		'attribute' => \&_attribute,
	);

	# Output handler.
	$self->{'output_handler'} = '';
	if (! $self->{'tags_obj'}->{'output_handler'}) {
		$self->{'output_handler'} 
			= $self->{'tags_obj'}->{'output_handler'};
	}

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
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	my $tag = shift;
	_flush_tag();
	push @tag, $tag, [];
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my $tag = shift;
	_flush_tag();
	my $ret = $tags->print(['end_'.$tag]);
	if (! $self->{'output_handler'}) {
		print $ret;
	}
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my $data = PYX::Utils::decode(shift);
	_flush_tag();
	my $ret = $tags->print([\$data]);
	if (! $self->{'output_handler'}) {
		print $ret;
	}
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	push @{$tag[$#tag]}, @_;
}

#------------------------------------------------------------------------------
sub _special_tag {
#------------------------------------------------------------------------------
# Process special tag.

	my $tag = shift;
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	if ($#tag > -1) {
		my $ret = $tags->print([@tag]);
		if (! $self->{'output_handler'}) {
			print $ret;
		}
		@tag = ();
	}
}

1;
