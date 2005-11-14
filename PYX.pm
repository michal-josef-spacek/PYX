#------------------------------------------------------------------------------
package PYX;
#------------------------------------------------------------------------------
# $Id: PYX.pm,v 1.13 2005-11-14 15:52:36 skim Exp $

# Pragmas.
use strict;

# Modules.
use Exporter;
use PYX::Utils qw(decode);

# Inheritance.
our @ISA = ('Exporter');

# Export.
our @EXPORT_OK = ('char', 'comment', 'end_tag', 'start_tag', 'instruction', 
	'attribute');

# Version.
our $VERSION = 0.01;

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

	my ($comment) = @_;
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

	my ($data) = @_;
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

=head1 NAME

PYX - A perl module for pyx handling.

=head1 SYNOPSIS

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX;

 # PYX object.
 my $pyx = PYX->new(
 );

=head1 DESCRIPTION

TODO

=head1 METHODS

=over 4

=item char

TODO

=item comment

TODO

=item end_tag

TODO

=item instruction

TODO

=item start_tag

TODO

=head1 AUTHORS

Michal Spacek <F<skim@skim.cz>> wrote version 0.1.

=cut
