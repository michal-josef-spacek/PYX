#------------------------------------------------------------------------------
package PYX::Checker;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);

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
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." unless exists $self->{$key};
                $self->{$key} = $val;
        }

	# Stack of tags.
	$self->{'stack'} = [];

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
	if (${$self->{'stack'}}[-1] =~ $tag) {
		pop @{$self->{'stack'}};
	} else {
		err "Cannot remove tag '$tag'.";
	}
}

1;
