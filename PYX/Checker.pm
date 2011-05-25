package PYX::Checker;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Debug.
	$self->{'debug'} = 0;

	# Process params.
	set_params($self, @params);

	# Stack of tags.
	$self->{'stack'} = [];

	# Object.
	return $self;
}

# Procesing data.
sub data {
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

# Adding tag.
sub add_tag {
	my ($self, $tag) = @_;
	if ($self->{'debug'}) {
		print "Start of '$tag'.\n";
	}
	push @{$self->{'stack'}}, $tag;
	return;
}

# Removing tag.
sub remove_tag {
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

 Mine:
   TODO

 From Class::Utils::set_params():
   Unknown parameter '%s'.

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

L<Class::Utils(3pm)>,
L<Error::Pure(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
