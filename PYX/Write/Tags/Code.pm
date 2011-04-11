package PYX::Write::Tags::Code;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Simple::Multiple qw(err);
use PYX::Parser;
use PYX::Utils qw(encode);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw(@tag $tag_code);

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
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
		'data' => \&_data,
		'instruction' => \&_instruction,
		'attribute' => \&_attribute,
		'comment' => \&_comment,
	);

	# Tag values.
	@tag = ();

	# Tag code.
	$tag_code = $self->{'tag_code'} = [];

	# Object.
	return $self;
}

# Gets tags code.
sub get_tags_code {
	my ($self, $reset_flag) = @_;
	my $tags_ar = $self->{'tag_code'};
	if ($reset_flag) {
		$self->reset;
	}
	return $tags_ar;
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

# Reset internal structures.
sub reset {
	my $self = shift;
	$tag_code = $self->{'tag_code'} = [];
	return;
}

# Process start of tag.
sub _start_tag {
	my (undef, $tag) = @_;
	_flush_tag();
	push @tag, $tag;
	return;
}

# Process end of tag.
sub _end_tag {
	my (undef, $tag) = @_;
	_flush_tag();
	push @{$tag_code}, 'end_'.$tag;
	return;
}

# Process data.
sub _data {
	my (undef, $decoded_data) = @_;
	my $data = encode($decoded_data);
	_flush_tag();
	push @{$tag_code}, \$data;
	return;
}

# Process attribute.
sub _attribute {
	my (undef, $attr, $value) = @_;
	if (ref $tag[-1] ne 'ARRAY') {
		push @tag, [];
	}
	push @{$tag[-1]}, $attr, $value;
	return;
}

# Process instruction tag.
sub _instruction {
	my (undef, $target, $code) = @_;
	# TODO Instruction by Tags.
	return;
}

# Flush tag values.
sub _flush_tag {
	if ($#tag > -1) {
		push @{$tag_code}, @tag;
		@tag = ();
	}
	return;
}

# Process comments.
sub _comment {
	my (undef, $decoded_comment) = @_;
	my $comment = encode($decoded_comment);
	# TODO Comment by Tags.
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Write::Tags::Code - TODO

=head1 SYNOPSIS

 use PYX::Write::Tags::Code;
 my $xml_norm = PYX::Write::Tags::Code->new(%parameters);
 TODO

=head1 METHODS

=over 8

=item B<new()>

 Constructor.

=over 8

=item * B<output_handler>

 TODO

=back

=item B<get_tags_code($reset_flag)>

 TODO

=item B<parse()>

 TODO

=item B<parse_file()>

 TODO

=item B<parse_handler()>

 TODO

=item B<reset()>

 TODO

=back

=head1 ERRORS

 Mine:
   TODO

 From Class::Utils::set_params():
   Unknown parameter '%s'.

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::Write::Tags::Code;

 # Object.
 my $tags_code = PYX::Write::Tags::Code->new(
   TODO
 );

=head1 DEPENDENCIES

L<Class::Utils(3pm)>,
L<Error::Simple::Multiple(3pm)>,
L<PYX::Parser(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
