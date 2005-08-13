#------------------------------------------------------------------------------
package Tags::PYX;
#------------------------------------------------------------------------------
# $Id: PYX.pm,v 1.9 2005-08-13 20:32:47 skim Exp $

# Pragmas.
use strict;

# Modules.
use PYX::Utils qw(decode);
use Exporter;

# Global variables.
use vars qw(@ISA @EXPORT_OK);

# Inheritance.
@ISA = ('Exporter');

# Export.
@EXPORT_OK = ('char', 'comment', 'end_tag', 'start_tag', 'instruction');

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
	while (@attr) {
		my ($key, $val) = (shift @attr, shift @attr);
		push @ret, "A$key ".decode($val);
	}
	return @ret;
}

1;

=head1 NAME

Tags::PYX - A perl module for pyx handling.

=head1 SYNOPSIS

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Tags::PYX;

 # PYX object.
 my $pyx = Tags::PYX->new(
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
