#------------------------------------------------------------------------------
package PYX;
#------------------------------------------------------------------------------
# $Id: PYX.pm,v 1.7 2005-07-18 15:31:53 skim Exp $

# Pragmas.
use strict;

# Version.
our $VERSION = 0.1;

# Modules.
use PYX::Utils qw(decode);

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
	return 'C'.decode($comment);
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
# TODO one instruction?

	my ($target, $data) = @_;
	return '?'.$target.' '.decode($data);
}

#------------------------------------------------------------------------------
sub start_tag {
#------------------------------------------------------------------------------
# Process begin tag.

	my ($tag, @attr) = @_;
	my @ret = ();
	push @ret, '('.$tag;
	while (@attr) {
		my ($key, $val) = (shift @attr, shift @attr);
		push @ret, "A$key ".decode($val);
	}
	return @ret;
}

1;

=head1 NAME

PYX - A perl module for indent handling.

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
