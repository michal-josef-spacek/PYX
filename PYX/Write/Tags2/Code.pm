#------------------------------------------------------------------------------
package PYX::Write::Tags2::Code;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($tag_code);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Process params.
        while (@params) {
                my $key = shift @params;
                my $val = shift @params;
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
sub get_tags_code {
#------------------------------------------------------------------------------
# Gets tags code.

	my $self = shift;
	return $self->{'tag_code'};
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx, $out) = @_;
	$self->{'pyx_parser'}->parse($pyx, $out);
	return;
}

#------------------------------------------------------------------------------
sub parse_file {
#------------------------------------------------------------------------------
# Parse file with pyx text.

	my ($self, $file) = @_;
	$self->{'pyx_parser'}->parse_file($file);
	return;
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.

	my ($self, $input_file_handler, $out) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler, $out);
	return;
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	my (undef, $tag) = @_;
	push @{$tag_code}, ['b', $tag];
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my (undef, $tag) = @_;
	push @{$tag_code}, ['e', $tag];
	return;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my (undef, $decoded_data) = @_;
	my $data = encode($decoded_data);
	push @{$tag_code}, ['d', $data];
	return;
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my (undef, $attr, $value) = @_;
	push @{$tag_code}, ['a', $attr, $value];
	return;
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction tag.

	my (undef, $target, $code) = @_;
	push @{$tag_code}, ['i', $target, $code];
	return;
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comments.

	my (undef, $decoded_comment) = @_;
	my $comment = encode($decoded_comment);
	push @{$tag_code}, ['c', $comment];
	return;
}

1;

=pod

=head1 NAME

PYX::Write::Tags2::Code - TODO

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

TODO

=head1 METHODS

=over 8

=item B<new()>

TODO

=item B<get_tags_code()>

TODO

=item B<parse()>

TODO

=item B<parse_file()>

TODO

=item B<parse_handler()>

TODO

=back

=head1 EXAMPLE

TODO

=head1 REQUIREMENTS

L<Error::Simple::Multiple>,
L<PYX::Parser>,
L<PYX::Utils>

=head1 AUTHOR

Michal Spacek L<tupinek@gmail.com>

=head1 VERSION

0.01

=cut
