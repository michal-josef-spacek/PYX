#------------------------------------------------------------------------------
package PYX::Get;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX::Parser;

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($stack $verbose);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Rules.
	$self->{'rules'} = [];

	# Verbose.
	$self->{'verbose'} = 0;

	# Process params.
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		err "Unknown parameter '$key'." unless exists $self->{$key};
		$self->{$key} = $val;
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'output_handler' => $self->{'output_handler'},
		'end_tag' => \&_end_tag,
		'start_tag' => \&_start_tag,
		'data' => \&_data,
	);

	# Tag values.
	$stack = [];

	# Verbose.
	$verbose = $self->{'verbose'};

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx, $out) = @_;
	$self->{'pyx_parser'}->parse($pyx, $out);
	return;
}

#------------------------------------------------------------------------------
sub parse_file {
#------------------------------------------------------------------------------
# Parse file with pyx text.

	my ($self, $file) = @_;
	$self->{'pyx_parser'}->parse_file($file);
	return;
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.

	my ($self, $input_file_handler, $out) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler, $out);
	return;
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process tag.

	my ($pyx_parser_obj, $tag) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	push @{$stack}, $tag;
	if ($verbose) {
		print $out join('/', @{$stack}), "\n";
	}
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my ($pyx_parser_obj, $tag) = @_;
	my $out = $pyx_parser_obj->{'output_handler'};
	if ($stack->[-1] eq $tag) {
		pop @{$stack};
	}
	if ($verbose && $#{$stack} > -1) {
		print $out join('/', @{$stack}), "\n";
	}
	return;
}

#------------------------------------------------------------------------------
sub _other {
#------------------------------------------------------------------------------
# Process other.

	return;
}

1;


__END__

=pod

=encoding utf8

=head1 NAME

PYX::Get - TODO

=head1 SYNOPSIS

TODO

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<output_handler>

TODO

=item * B<rules>

TODO

=item * B<verbose>

TODO

=back

=item B<parse()>

TODO

=item B<parse_file()>

TODO

=item B<parse_handler()>

TODO

=back

=head1 ERRORS

 TODO

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::Get;

 # PYX::Get object.
 my $pyx = PYX::Get->new(
   TODO
 );

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
