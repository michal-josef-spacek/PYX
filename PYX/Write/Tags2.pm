#------------------------------------------------------------------------------
package PYX::Write::Tags2;
#------------------------------------------------------------------------------
# $Id: Tags2.pm,v 1.10 2007-04-09 09:00:24 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($tags @tag);

#------------------------------------------------------------------------------
sub new($%) {
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
                err "Bad parameter '$key'." unless exists $self->{$key};
                $self->{$key} = $val;
        }

	# If doesn't exist Tags object.
	unless ($self->{'tags_obj'} && ($self->{'tags_obj'}->isa('Tags2'))) {
		err "Bad 'Tags2' object '$self->{'tags_obj'}'.";
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
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
	$tags->put(['b', shift]);
}

#------------------------------------------------------------------------------
sub _end_tag($$) {
#------------------------------------------------------------------------------
# Process end of tag.

	shift;
	$tags->put(['e', shift]);
}

#------------------------------------------------------------------------------
sub _data($@) {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my @data = @_;
	$tags->put(['d', map(encode($_), @data)]);
}

#------------------------------------------------------------------------------
sub _attribute($@) {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	$tags->put(['a', @_]);
}

#------------------------------------------------------------------------------
sub _instruction($@) {
#------------------------------------------------------------------------------
# Process instruction tag.

	shift;
	$tags->put(['i', @_]);
}

#------------------------------------------------------------------------------
sub _comment($$) {
#------------------------------------------------------------------------------
# Process comments.

	shift;
	$tags->put(['c', encode(shift)]);
}

1;

=pod

=head1 NAME

PYX::Write::Tags2 - TODO

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

TODO

=head1 METHODS

=over 8

=item B<new()>

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
