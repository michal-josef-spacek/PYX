#------------------------------------------------------------------------------
package PYX::Filter;
#------------------------------------------------------------------------------
# $Id: Filter.pm,v 1.3 2005-07-02 16:20:57 skim Exp $
# Rules:
# - drop
#   - full_tag.
#   - end_tag.
#   - data.
# - filter

# Pragmas.
use strict;

# Modules.
use Carp;

# Version.
our $VERSION = 0.1;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = {};
	bless $self, $class;

	# Rules.
	$self->{'rule'} = []; 

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

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub add_rule {
#------------------------------------------------------------------------------
# Adding filter rule.

	my $self = shift;
}

#------------------------------------------------------------------------------
sub filter {
#------------------------------------------------------------------------------
# Filter output.

	my $self = shift;
	my $string = shift;
}

#------------------------------------------------------------------------------
sub get_rules {
#------------------------------------------------------------------------------
# Gets filtering rules.

	my $self = shift;
	return $self->{'rule'};
}

1;
