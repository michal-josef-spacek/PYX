#------------------------------------------------------------------------------
package PYX;
#------------------------------------------------------------------------------

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

#------------------------------------------------------------------------------
sub char {
#------------------------------------------------------------------------------
# Process char between tags.

	my $char = shift;
	return '-'.decode($char);
}

#------------------------------------------------------------------------------
sub comment {
#------------------------------------------------------------------------------
# Process comment.

	my $comment = shift;
	return '_'.decode($comment);
}

#------------------------------------------------------------------------------
sub end_tag {
#------------------------------------------------------------------------------
# Process end tag.

	my $tag = shift;
	return ')'.$tag;
}

#------------------------------------------------------------------------------
sub instruction {
#------------------------------------------------------------------------------
# Process instruction.

	my $data = shift;
	return '?'.decode($data);
}

#------------------------------------------------------------------------------
sub start_tag {
#------------------------------------------------------------------------------
# Process begin tag.

	my ($tag, @attr) = @_;
	my @ret = ();
	push @ret, '('.$tag;
	push @ret, attribute(@attr) if $#attr > -1;
	return @ret;
}

#------------------------------------------------------------------------------
sub attribute {
#------------------------------------------------------------------------------
# Process attribute.

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

=head1 DESCRIPTION

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

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.04

=cut
