package PYX::Write::Tags2::Code;

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
use vars qw($tag_code);

# Constructor.
sub new {
	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Process params.
	set_params($self, @params);

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

# Gets tags code.
sub get_tags_code {
	my $self = shift;
	return $self->{'tag_code'};
}

# Parse pyx text or array of pyx text.
sub parse {
	my ($self, $pyx, $out) = @_;
	$self->{'pyx_parser'}->parse($pyx, $out);
	return;
}

# Parse file with pyx text.
sub parse_file {
	my ($self, $file) = @_;
	$self->{'pyx_parser'}->parse_file($file);
	return;
}

# Parse from handler.
sub parse_handler {
	my ($self, $input_file_handler, $out) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler, $out);
	return;
}

# Process start of tag.
sub _start_tag {
	my (undef, $tag) = @_;
	push @{$tag_code}, ['b', $tag];
	return;
}

# Process end of tag.
sub _end_tag {
	my (undef, $tag) = @_;
	push @{$tag_code}, ['e', $tag];
	return;
}

# Process data.
sub _data {
	my (undef, $decoded_data) = @_;
	my $data = encode($decoded_data);
	push @{$tag_code}, ['d', $data];
	return;
}

# Process attribute.
sub _attribute {
	my (undef, $attr, $value) = @_;
	push @{$tag_code}, ['a', $attr, $value];
	return;
}

# Process instruction tag.
sub _instruction {
	my (undef, $target, $code) = @_;
	push @{$tag_code}, ['i', $target, $code];
	return;
}

# Process comments.
sub _comment {
	my (undef, $decoded_comment) = @_;
	my $comment = encode($decoded_comment);
	push @{$tag_code}, ['c', $comment];
	return;
}

1;

__END__

=pod

=encoding utf8

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
L<PYX::Utils(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
