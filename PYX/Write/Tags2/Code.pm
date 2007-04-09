#------------------------------------------------------------------------------
package PYX::Write::Tags2::Code;
#------------------------------------------------------------------------------
# $Id: Code.pm,v 1.8 2007-04-09 11:36:06 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($tag_code);

#------------------------------------------------------------------------------
sub new($%) {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." unless exists $self->{$key};
                $self->{$key} = $val;
        }

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'output_handler' => $self->{'output_handler'},
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
		'data' => \&_data,
		'instruction' => \&_instruction,
		'attribute' => \&_attribute,
		'comment' => \&_comment,
	);

	# Tag code.
	$tag_code = $self->{'tag_code'} = [];

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub get_tags_code($) {
#------------------------------------------------------------------------------
# Gets tags code.

	my $self = shift;
	return $self->{'tag_code'};
}

#------------------------------------------------------------------------------
sub parse($$$) {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx, $out) = @_;
	$self->{'pyx_parser'}->parse($pyx, $out);
}

#------------------------------------------------------------------------------
sub parse_file($$) {
#------------------------------------------------------------------------------
# Parse file with pyx text.

	my ($self, $file) = @_;
	$self->{'pyx_parser'}->parse_file($file);
}

#------------------------------------------------------------------------------
sub parse_handler($$$) {
#------------------------------------------------------------------------------
# Parse from handler.

	my ($self, $input_file_handler, $out) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler, $out);
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag($$) {
#------------------------------------------------------------------------------
# Process start of tag.

	shift;
	my $tag = shift;
	push @{$tag_code}, ['b', $tag];
}

#------------------------------------------------------------------------------
sub _end_tag($$) {
#------------------------------------------------------------------------------
# Process end of tag.

	shift;
	my $tag = shift;
	push @{$tag_code}, ['e', $tag];
}

#------------------------------------------------------------------------------
sub _data($$) {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my $data = encode(shift);
	push @{$tag_code}, ['d', $data];
}

#------------------------------------------------------------------------------
sub _attribute($@) {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	push @{$tag_code}, ['a', @_];
}

#------------------------------------------------------------------------------
sub _instruction($$$) {
#------------------------------------------------------------------------------
# Process instruction tag.

	shift;
	my ($target, $data) = @_;
	push @{$tag_code}, ['i', $target, $data];
}

#------------------------------------------------------------------------------
sub _comment($$) {
#------------------------------------------------------------------------------
# Process comments.

	shift;
	my $comment = encode(shift);
	push @{$tag_code}, ['c', $comment];
}

1;
