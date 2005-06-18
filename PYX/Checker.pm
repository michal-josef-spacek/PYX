#------------------------------------------------------------------------------
package PYX::Checker;
#------------------------------------------------------------------------------
# $Id: Checker.pm,v 1.3 2005-06-18 01:01:55 skim Exp $

# Version.
our $VERSION = 0.1;

# Modules.
use Carp;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = {};
	bless $self, $class;

	# TODO Params.

	# Stack of tags.
	$self->{'stack'} = [];

	# Class.
	$self->{'class'} = $class;

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub data {
#------------------------------------------------------------------------------
# Procesing data.

	my $self = shift;
	my $data = shift;

	# Begin of tag.
	if ($data =~ /^\(/) {
		$data =~ s/^\(//;
		$self->add_tag($data);

	# End of tag.
	} elsif ($data =~ /^\)/) {
		$data =~ s/^\)//;
		$self->remove_tag($data);
		
	# Nop.
	} else {
	}
}

#------------------------------------------------------------------------------
sub add_tag {
#------------------------------------------------------------------------------
# Adding tag.

	my $self = shift;
	my $tag = shift;
	push @{$self->{'stack'}}, $tag;
}

#------------------------------------------------------------------------------
sub remove_tag {
#------------------------------------------------------------------------------
# Removing tag.

	my $self = shift;
	my $tag = shift;
	if (${$self->{'stack'}}[$#{$self->{'stack'}}] =~ $tag) {
		pop @{$self->{'stack'}};
	} else {
		croak "$self->{'class'}: Cannot remove tag '$tag'.";
	}
}

1;
