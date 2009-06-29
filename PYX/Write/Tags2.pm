#------------------------------------------------------------------------------
package PYX::Write::Tags2;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX::Parser;
use PYX::Utils qw(encode set_params);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($tags @tag);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Tags object.
	$self->{'tags_obj'} = '';

	# Process params.
	set_params($self, @params);

	# If doesn't exist Tags object.
	if (! $self->{'tags_obj'} 
		|| (! $self->{'tags_obj'}->isa('Tags2::Output::Indent')
		&& !  $self->{'tags_obj'}->isa('Tags2::Output::Raw'))) {

		err "Bad 'Tags2::Ooutput::Indent' object ".
			"'$self->{'tags_obj'}'.";
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
	$tags->put(['b', $tag]);
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my (undef, $tag) = @_;
	$tags->put(['e', $tag]);
	return;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my (undef, $data) = @_;
	$tags->put(['d', encode($data)]);
	return;
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my (undef, $attr, $value) = @_;
	$tags->put(['a', $attr, $value]);
	return;
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction tag.

	my (undef, $target, $code) = @_;
	$tags->put(['i', $target, $code]);
	return;
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comments.

	my (undef, $comment) = @_;
	$tags->put(['c', encode($comment)]);
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Write::Tags2 - TODO

=head1 SYNOPSIS

TODO

=head1 METHODS

=over 8

=item B<new()>

Constructor.

=over 8

=item * B<tags_obj>

 TODO

=back

=item B<parse()>

TODO

=item B<parse_file()>

TODO

=item B<parse_handler()>

TODO

=back

=head1 ERRORS

 Mine:
   TODO

 From PYX::Utils::set_params():
   Unknown parameter '%s'.

=head1 EXAMPLE

TODO

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>,
L<PYX::Parser(3pm)>,
L<PYX::Utils(3pm)>

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<tupinek@gmail.com>

=head1 VERSION

0.01

=cut
