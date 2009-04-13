------------------------------------------------------------------------------
package PYX::Filter;
#------------------------------------------------------------------------------

# TODO
# Rules:
# - policy - accept, drop
# - accept
# - drop
#   - full_tag.
#   - end_tag.
#   - data.
        
# Real rules:
# Accept only.
# from => ['(tag', 'Astyle blabla'],
# to   => [)tag],

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

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Rules.
	# {
	#   'first' => {
	#     'from' => ['(tag'], 
	#     'to' => [')tag'],
	#     'including' => 1,
	#     'callback' => \&function,
	#   }
	#   'second' => {
	#     'from' => [')tag', '(br', ')br', '(tag2'], 
	#     'to' => [')oo'],
	#   }
	# }
	# TODO Check rules.
	$self->{'rules'} = {}; 

	# Process params.
        while (@params) {
                my $key = shift @params;
                my $val = shift @params;
		if (! exists $self->{$key}) {
	                err "Unknown parameter '$key'.";
		}
                $self->{$key} = $val;
        }

	# Initialization.
	$self->_init;

	# Actual stay.
#	$self->{'act_stay'} = {};
#	foreach (keys %{$rules}) {
#		$act_stay->{$_} = 0;
#	}

	# Results.
	# {
	#   'first' => [
	#     ['(br', ')br'],
	#     ['-text'],
	#   ]
	# }
	$self->{'res'} = {};

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.
# TODO $out in arguments?

	my ($self, $pyx) = @_;

	# Input data.
	my @text;
	if (ref $pyx eq 'ARRAY') {
		@text = @{$pyx};
	} else {
		@text = split(/\n/, $pyx);
	}

	# Parse.
	foreach my $line (@text) {
		$self->_process($line);
	}
}

#------------------------------------------------------------------------------
sub parse_file {
#------------------------------------------------------------------------------
# Parse file with pyx text.
# TODO $out in arguments?

	my ($self, $input_file) = @_;
	open my $inf, '<', $input_file 
		or err "Cannot open file '$input_file'.";
	$self->parse_handler($inf);
	close $inf or err "Cannot close file '$input_file'.";
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.
# TODO $out in arguments?

	my ($self, $input_file_handler) = @_;
	if (! $input_file_handler || ref $input_file_handler ne 'GLOB') {
		err 'No input handler.';
	}
	while (my $line = <$input_file_handler>) {
		chomp $line;
		$self->_process($line);
	}
}

#------------------------------------------------------------------------------
#sub add_rule {
#------------------------------------------------------------------------------
# Adding filter rule.
# TODO

#	my $self = shift;
#}

#------------------------------------------------------------------------------
#sub get_rules {
#------------------------------------------------------------------------------
# Gets filtering rules.
# TODO

#	my $self = shift;
#	return $self->{'rule'};
#}

#------------------------------------------------------------------------------
# Internal functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _init {
#------------------------------------------------------------------------------
# Initialization.

	my $self = shift;

	# Print flag.
	$self->{'print_flag'} = 0;
}

#------------------------------------------------------------------------------
sub _process {
#------------------------------------------------------------------------------
# Process pyx item.

	my ($self, $line) = @_;
	foreach my $res (keys %{$self->{'res'}}) {
		
	}
	foreach my $rule (keys %{$self->{'rules'}}) {

		# 

		
#		if ($act_stay->{$rule} == $#{$rules->{$rule}->{'from'}}) {
#			last;
#		}
	}
	
#	if ($self->{'print_flag'}) {
#		my $out = $self->{'output_handler'};
#		print $out $line, "\n";
#	}
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Filter - TODO

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

=back

=item B<parse()>

TODO

=item B<parse_file()>

TODO

=item B<parse_handler()>

TODO

=back

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::Filter;

 # PYX::Filter object.
 my $pyx = PYX::Filter->new(
   TODO
 );

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>.

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
