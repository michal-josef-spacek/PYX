package PYX;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use PYX::Utils qw(decode);
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw(attribute char comment end_tag instruction
	start_tag);

# Version.
our $VERSION = 0.01;

# Process attribute.
sub attribute {
	my (@attr) = @_;
	my @ret = ();
	while (@attr) {
		my ($key, $val) = (shift @attr, shift @attr);
		push @ret, "A$key ".decode($val);
	}
	return @ret;
}

# Process char between tags.
sub char {
	my $char = shift;
	return '-'.decode($char);
}

# Process comment.
sub comment {
	my $comment = shift;
	return '_'.decode($comment);
}

# Process end tag.
sub end_tag {
	my $tag = shift;
	return ')'.$tag;
}

# Process instruction.
sub instruction {
	my ($target, $code) = @_;
	my $ret = '?'.decode($target);
	if ($code) {
		$ret .= ' '.decode($code);
	}
	return $ret;
}

# Process begin tag.
sub start_tag {
	my ($tag, @attr) = @_;
	my @ret = ();
	push @ret, '('.$tag;
	if (@attr) {
		push @ret, attribute(@attr);
	}
	return @ret;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX - A perl module for pyx handling.

=head1 SYNOPSIS

TODO

=head1 SUBROUTINES

=over 8

=item C<char()>

TODO

=item C<comment()>

TODO

=item C<end_tag()>

TODO

=item C<instruction()>

TODO

=item C<start_tag()>

TODO

=item C<attribute()>

TODO

=back

=head1 ERRORS

 No errors.

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX;

 # PYX object.
 my $pyx = PYX->new(
         TODO
 );

=head1 DEPENDENCIES

L<Exporter>,
L<PYX::Utils>,
L<Readonly>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
