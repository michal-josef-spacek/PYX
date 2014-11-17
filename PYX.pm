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
sub end_tag {
	my $tag = shift;
	return ')'.$tag;
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

PYX - A perl module for PYX handling.

=head1 SYNOPSIS

 use PYX qw(attribute char comment end_tag instruction start_tag);
 my @data = attribute(@attr);
 my @data = char($char);
 my @data = comment($comment);
 my @data = end_tag($tag);
 my @data = instruction($target, $code);
 my @data = start_tag($tag, @attr);

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

=item C<end_tag($tag)>

 Encode end of element as PYX.
 Returns array of encoded lines.

=item C<instruction($target, $code)>

 Encode instruction as PYX.
 Returns array of encoded lines.

=item C<start_tag($tag, @attr)>

 Encode begin of element as PYX.
 Returns array of encoded lines.

=back

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX qw(attribute char comment end_tag instruction start_tag);

 # Example output.
 my @data = (
         instruction('xml', 'foo'),
         start_tag('tag'),
         attribute('key', 'val'),
         comment('comment'),
         char('data'),
         end_tag('tag'),
 );

 # Print out.
 map { print $_."\n" } @data;

 # Output:
 # ?xml foo
 # (tag
 # Akey val
 # _comment
 # -data
 # )tag

=head1 DEPENDENCIES

L<Exporter>,
L<PYX::Utils>,
L<Readonly>.

=head1 SEE ALSO

L<App::SGML2PYX>,
L<PYX::Checker>,
L<PYX::Filter>,
L<PYX::GraphViz>,
L<PYX::Optimalization>,
L<PYX::Parser>,
L<PYX::Sort>,
L<PYX::Stack>,
L<PYX::Utils>,
L<PYX::Write::Raw>,
L<PYX::Write::Tags>,
L<PYX::Write::Tags::Code>,
L<PYX::XMLNorm>.

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>.

=head1 LICENSE AND COPYRIGHT

BSD 2-Clause License

=head1 VERSION

0.01

=cut
