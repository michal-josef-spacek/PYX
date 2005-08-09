#------------------------------------------------------------------------------
package PYX::Checker;
#------------------------------------------------------------------------------
# $Id: Checker.pm,v 1.7 2005-08-09 07:59:09 skim Exp $

# Pragmas.
use strict;

# Modules.
use Carp;

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Debug.
	$self->{'debug'} = 0;

	# Process params.
	croak "$class: Created with odd number of parameters - should be ".
		"of the form option => value." if (@_ % 2);
	for (my $x = 0; $x <= $#_; $x += 2) {
		if (exists $self->{$_[$x]}) {
			$self->{$_[$x]} = $_[$x+1];
		} else {
			croak "$class: Bad parameter '$_[$x]'.";
		}
	}

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
	print "Start of '$tag'.\n" if $self->{'debug'};
	push @{$self->{'stack'}}, $tag;
}

#------------------------------------------------------------------------------
sub remove_tag {
#------------------------------------------------------------------------------
# Removing tag.

	my $self = shift;
	my $tag = shift;
	print "End of '$tag'.\n" if $self->{'debug'};
	if (${$self->{'stack'}}[$#{$self->{'stack'}}] =~ $tag) {
		pop @{$self->{'stack'}};
	} else {
		croak "$self->{'class'}: Cannot remove tag '$tag'.";
	}
}

1;
