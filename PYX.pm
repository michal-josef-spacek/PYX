package PYX;

use base qw(Exporter);
use strict;
use warnings;

use PYX::Utils qw(decode);
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw(attribute char comment end_element instruction
	start_element);

our $VERSION = 0.06;

# Encode attribute as PYX.
sub attribute {
	my (@attr) = @_;
	my @ret = ();
	while (@attr) {
		my ($key, $val) = (shift @attr, shift @attr);
		push @ret, "A$key ".decode($val);
	}
	return @ret;
}

# Encode characters between elements as PYX.
sub char {
	my $char = shift;
	return '-'.decode($char);
}

# Encode comment as PYX.
sub comment {
	my $comment = shift;
	return '_'.decode($comment);
}

# Encode end of element as PYX.
sub end_element {
	my $elem = shift;
	return ')'.$elem;
}

# Encode instruction as PYX.
sub instruction {
	my ($target, $code) = @_;
	my $ret = '?'.decode($target);
	if ($code) {
		$ret .= ' '.decode($code);
	}
	return $ret;
}

# Encode begin of element as PYX.
sub start_element {
	my ($elem, @attr) = @_;
	my @ret = ();
	push @ret, '('.$elem;
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

PYX - A perl module for PYX handling.

=head1 SYNOPSIS

 use PYX qw(attribute char comment end_element instruction start_element);
 my @data = attribute(@attr);
 my @data = char($char);
 my @data = comment($comment);
 my @data = end_element($elem);
 my @data = instruction($target, $code);
 my @data = start_element($elem, @attr);

=head1 SUBROUTINES

=over 8

=item C<attribute(@attr)>

 Encode attribute as PYX.
 Returns array of encoded lines.

=item C<char($char)>

 Encode characters between elements as PYX.
 Returns array of encoded lines.

=item C<comment($comment)>

 Encode comment as PYX.
 Returns array of encoded lines.

=item C<end_element($elem)>

 Encode end of element as PYX.
 Returns array of encoded lines.

=item C<instruction($target, $code)>

 Encode instruction as PYX.
 Returns array of encoded lines.

=item C<start_element($elem, @attr)>

 Encode begin of element as PYX.
 Returns array of encoded lines.

=back

=head1 EXAMPLE

 use strict;
 use warnings;

 use PYX qw(attribute char comment end_element instruction start_element);

 # Example output.
 my @data = (
         instruction('xml', 'foo'),
         start_element('element'),
         attribute('key', 'val'),
         comment('comment'),
         char('data'),
         end_element('element'),
 );

 # Print out.
 map { print $_."\n" } @data;

 # Output:
 # ?xml foo
 # (element
 # Akey val
 # _comment
 # -data
 # )element

=head1 DEPENDENCIES

L<Exporter>,
L<PYX::Utils>,
L<Readonly>.

=head1 SEE ALSO

=over

=item L<Task::PYX>

Install the PYX modules.

=back

=head1 REPOSITORY

L<https://github.com/tupinek/PYX>

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2005-2016 Michal Špaček

BSD 2-Clause License

=head1 VERSION

0.06

=cut
