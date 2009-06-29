#------------------------------------------------------------------------------
package PYX::Write::Tags;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX::Parser;
use PYX::Utils qw(encode set_params);

# Version.
our $VERSION = 0.02;

# Global variables.
use vars qw($tags_obj @tags);

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
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my (undef, $attr, $value) = @_;
	if (ref $tags[-1] ne 'ARRAY') {
		push @tags, [];
	}
	push @{$tags[-1]}, $attr, $value;
	return;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my (undef, $decoded_data) = @_;
	my $data = encode($decoded_data);
	_flush_tag();
	$tags_obj->print([\$data]);
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my (undef, $tag) = @_;
	_flush_tag();
	$tags_obj->print(['end_'.$tag]);
	return;
}

#------------------------------------------------------------------------------
sub _flush_tag {
#------------------------------------------------------------------------------
# Flush tag values.

	if ($#tags > -1) {
		$tags_obj->print([@tags]);
		@tags = ();
	}
	return;
}

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	my (undef, $tag) = @_;
	_flush_tag();
	push @tags, $tag;
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Write::Tags - TODO

=head1 SYNOPSIS

 use PYX::Write::Tags;
 my $xml_norm = PYX::Write::Tags->new(%parameters);
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

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::Write::Tags;

 # Object.
 my $xml_norm = PYX::Write::Tags->new(
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

0.02

=cut
