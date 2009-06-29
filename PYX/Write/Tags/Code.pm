#------------------------------------------------------------------------------
package PYX::Write::Tags::Code;
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
use vars qw(@tag $tag_code);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

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

#------------------------------------------------------------------------------
sub get_tags_code {
#------------------------------------------------------------------------------
# Gets tags code.

	my ($self, $reset_flag) = @_;
	my $tags_ar = $self->{'tag_code'};
	if ($reset_flag) {
		$self->reset;
	}
	return $tags_ar;
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
sub reset {
#------------------------------------------------------------------------------
# Reset internal structures.

	my $self = shift;
	$tag_code = $self->{'tag_code'} = [];
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
	_flush_tag();
	push @tag, $tag;
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my (undef, $tag) = @_;
	_flush_tag();
	push @{$tag_code}, 'end_'.$tag;
	return;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my (undef, $decoded_data) = @_;
	my $data = encode($decoded_data);
	_flush_tag();
	push @{$tag_code}, \$data;
	return;
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my (undef, $attr, $value) = @_;
	if (ref $tag[-1] ne 'ARRAY') {
		push @tag, [];
	}
	push @{$tag[-1]}, $attr, $value;
	return;
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction tag.

	my (undef, $target, $code) = @_;
	# TODO Instruction by Tags.
	return;
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	if ($#tag > -1) {
		push @{$tag_code}, @tag;
		@tag = ();
	}
	return;
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comments.

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

 From PYX::Utils::set_params():
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
