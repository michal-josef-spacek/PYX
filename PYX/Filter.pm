#------------------------------------------------------------------------------
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
	open(INF, "<$input_file") || err "Cannot open file '$input_file'.";
	$self->parse_handler(\*INF);
	close(INF) || err "Cannot close file '$input_file'.";
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.
# TODO $out in arguments?

	my ($self, $input_file_handler) = @_;
	err "No input handler." if ! $input_file_handler 
		|| ref $input_file_handler ne 'GLOB';
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
