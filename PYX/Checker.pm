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

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Debug.
	$self->{'debug'} = 0;

	# Process params.
        while (@params) {
                my $key = shift @params;
                my $val = shift @params;
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

	my ($self, $data) = @_;

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
	return;
}

#------------------------------------------------------------------------------
sub add_tag {
#------------------------------------------------------------------------------
# Adding tag.

	my ($self, $tag) = @_;
	if ($self->{'debug'}) {
		print "Start of '$tag'.\n";
	}
	push @{$self->{'stack'}}, $tag;
	return;
}

#------------------------------------------------------------------------------
sub remove_tag {
#------------------------------------------------------------------------------
# Removing tag.

	my ($self, $tag) = @_;
	if ($self->{'debug'}) {
		print "End of '$tag'.\n";
	}
	if (${$self->{'stack'}}[-1] =~ $tag) {
		pop @{$self->{'stack'}};
	} else {
		err "Cannot remove tag '$tag'.";
	}
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Checker - TODO

=head1 SYNOPSIS

TODO

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<debug>

TODO

=back

=item B<data()>

TODO

=item B<add_tag()>

TODO

=item B<remove_tag()>

TODO

=back

=head1 ERRORS

 TODO

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::Checker;

 # PYX::Filter object.
 my $pyx = PYX::Checker->new(
   TODO
 );

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>.

=head1 SEE ALOS

 TODO

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
