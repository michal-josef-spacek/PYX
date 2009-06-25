#------------------------------------------------------------------------------
package PYX::Write::Raw;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX::Parser;
use PYX::Utils qw(encode entity_encode);

# Global variables.
use vars qw(@tag $tag_open);

# Version.
our $VERSION = 0.01;

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

	# Open tag.
	$self->{'tag_open'} = 0;
	$tag_open = \$self->{'tag_open'};

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
# Internal functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $tag = shift;
	_end_of_start_tag($pyx_parser_obj);
	print {$out} "<$tag";
	${$tag_open} = 1;
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	my ($pyx_parser_obj, $tag) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	_end_of_start_tag($pyx_parser_obj);
	print {$out} "</$tag>";
	return;
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	my ($pyx_parser_obj, $decoded_data) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	my $data = encode($decoded_data);
	_end_of_start_tag($pyx_parser_obj);
	print {$out} entity_encode($data);
	return;
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my ($pyx_parser_obj, $att, $attval) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	print {$out} " $att=\"", entity_encode($attval), '"';
	return;
}

#------------------------------------------------------------------------------
sub _instruction {
#------------------------------------------------------------------------------
# Process instruction.

	my ($pyx_parser_obj, $target, $data) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	_end_of_start_tag($pyx_parser_obj);
	print {$out} "<?$target ", encode($data), "?>";
	return;
}

#------------------------------------------------------------------------------
sub _end_of_start_tag {
#------------------------------------------------------------------------------
# Ends start tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if (${$tag_open}) {
		print {$out} '>';
		${$tag_open} = 0;
	}
	return;
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comment.

	my ($pyx_parser_obj, $comment) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	print {$out} '<!--'.encode($comment).'-->';
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Write::Raw - TODO

=head1 SYNOPSIS

TODO

=head1 SUBROUTINES

=over 8

=item B<new()>

 Constructor.

=over 8

=item * B<output_handler>

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

TODO

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::Write::Raw;

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
