package PYX::Filter;

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
use Class::Utils qw(set_params);
use Error::Pure qw(err);

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
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
	set_params($self, @params);

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

# Parse pyx text or array of pyx text.
# TODO $out in arguments?
sub parse {
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

# Parse file with pyx text.
# TODO $out in arguments?
sub parse_file {
	my ($self, $input_file) = @_;
	open my $inf, '<', $input_file 
		or err "Cannot open file '$input_file'.";
	$self->parse_handler($inf);
	close $inf or err "Cannot close file '$input_file'.";
}

# Parse from handler.
# TODO $out in arguments?
sub parse_handler {
	my ($self, $input_file_handler) = @_;
	if (! $input_file_handler || ref $input_file_handler ne 'GLOB') {
		err 'No input handler.';
	}
	while (my $line = <$input_file_handler>) {
		chomp $line;
		$self->_process($line);
	}
}

# Adding filter rule.
# TODO
#sub add_rule {
#	my $self = shift;
#}

# Gets filtering rules.
# TODO
#sub get_rules {
#	my $self = shift;
#	return $self->{'rule'};
#}

# Initialization.
sub _init {
	my $self = shift;

	# Print flag.
	$self->{'print_flag'} = 0;
}

# Process PYX item.
sub _process {
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
#		print {$out} $line, "\n";
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
 use PYX::Filter;

 # PYX::Filter object.
 my $pyx = PYX::Filter->new(
   TODO
 );

=head1 DEPENDENCIES

L<Class::Utils(3pm)>,
L<Error::Pure(3pm)>.

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
