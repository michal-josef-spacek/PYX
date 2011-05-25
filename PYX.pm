package PYX;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use PYX::Utils qw(decode);
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw(char comment end_tag start_tag 
	instruction attribute);

# Version.
our $VERSION = 0.04;

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

=item B<char()>

TODO

=item B<comment()>

TODO

=item B<end_tag()>

TODO

=item B<instruction()>

TODO

=item B<start_tag()>

TODO

=item B<attribute()>

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

L<Exporter(3pm)>,
L<PYX::Utils(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.04

=cut
