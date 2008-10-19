#------------------------------------------------------------------------------
package PYX::Write::Tags;
#------------------------------------------------------------------------------

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.02;

# Global variables.
use vars qw($tags_obj @tags);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Tags object.
	$self->{'tags_obj'} = '';

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." unless exists $self->{$key};
                $self->{$key} = $val;
        }

	# Check to 'Tags::*' object.
	unless ($self->{'tags_obj'} 
		&& (UNIVERSAL::isa($self->{'tags_obj'}, 'Tags')
		|| UNIVERSAL::isa($self->{'tags_obj'}, 'Tags::Running')
		|| UNIVERSAL::isa($self->{'tags_obj'}, 'Tags::Structure'))) {

		err "Bad 'Tags::*' object '$self->{'tags_obj'}'.";
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
		'data' => \&_data,
		'instruction' => \&_instruction,
		'attribute' => \&_attribute,
	);

	# Tags object.
	$tags_obj = $self->{'tags_obj'};

	# Tag values.
	@tags = ();

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx, $out) = @_;
	$self->{'pyx_parser'}->parse($pyx, $out);
}

#------------------------------------------------------------------------------
sub parse_file {
#------------------------------------------------------------------------------
# Parse file with pyx text.

	my ($self, $file) = @_;
	$self->{'pyx_parser'}->parse_file($file);
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.

	my ($self, $input_file_handler, $out) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler, $out);
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	if (ref $tags[-1] ne 'ARRAY') {
		push @tags, [];
	}
	push @{$tags[-1]}, @_;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my $data = encode(shift);
	_flush_tag();
	$tags_obj->print([\$data]);
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	shift;
	my $tag = shift;
	_flush_tag();
	$tags_obj->print(['end_'.$tag]);
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	if ($#tags > -1) {
		$tags_obj->print([@tags]);
		@tags = ();
	}
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
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	shift;
	my $tag = shift;
	_flush_tag();
	push @tags, $tag;
}

1;
