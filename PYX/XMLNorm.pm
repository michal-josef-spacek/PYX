#------------------------------------------------------------------------------
package PYX::XMLNorm;
#------------------------------------------------------------------------------
# $Id: XMLNorm.pm,v 1.14 2005-11-14 17:04:47 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;
use PYX qw(end_tag);
use PYX::Parser;

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($stack $rules $flush_stack);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Input file handler.
	$self->{'input_file_handler'} = '';

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# XML normalization rules.
	$self->{'rules'} = {};

	# Flush stack on finalization.
	$self->{'flush_stack'} = 0;

	# Process params.
	while (@_) {
		my $key = shift;
		my $val = shift;
		err "Unknown parameter '$key'." if ! exists $self->{$key};
		$self->{$key} = $val;
	}

	# Check to rules.
	err "Cannot exist XML normalization rules."
		if keys %{$self->{'rules'}} == 0;

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'output_handler' => $self->{'output_handler'},
		'output_rewrite' => 1,
		'end_tag' => \&_end_tag,
		'final' => \&_final,
		'start_tag' => \&_start_tag,
	);

	# Tag values.
	$stack = [];

	# Rules.
	$rules = $self->{'rules'};

	# Flush stack.
	$flush_stack = $self->{'flush_stack'};

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse text.

	my $self = shift;
	my $pyx_array_ref = shift;
	my $out = shift || $self->{'output_handler'};
	$self->{'pyx_parser'}->parse($pyx_array_ref, $out);
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.

	my $self = shift;
	my $tmp = shift || $self->{'input_file_handler'};
	my $out = shift || $self->{'output_handler'};
	$self->{'pyx_parser'}->parse_handler($tmp, $out);
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	my $tag = shift;
	if (exists $rules->{'*'}) {
		foreach my $tmp (@{$rules->{'*'}}) {
			if ($#{$stack} > -1 && $stack->[-1] eq $tmp) {
				print $out end_tag($tmp), "\n";
				if ($stack->[-1] eq $tmp) {
					pop @{$stack};
				}
			}
		}
	}
	if (exists $rules->{$tag}) {
		foreach my $tmp (@{$rules->{$tag}}) {
			if ($#{$stack} > -1 && $stack->[-1] eq $tmp) {
				print $out end_tag($tmp), "\n";
				if ($stack->[-1] eq $tmp) {
					pop @{$stack};
				}
			}
		}
	}
	push @{$stack}, $tag;
	print $out $pyx_parser->{'line'}, "\n";
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	my $tag = shift;
	if (exists $rules->{'*'}) {
		foreach my $tmp (@{$rules->{'*'}}) {
			if ($tmp ne $tag && $stack->[-1] eq $tmp) {
				print $out end_tag($tmp), "\n";
				if ($stack->[-1] eq $tmp) {
					pop @{$stack};
				}
			}
		}
	}
	if (exists $rules->{$tag}) {
		foreach my $tmp (@{$rules->{$tag}}) {
			if ($tmp ne $tag && $stack->[-1] eq $tmp) {
				print $out end_tag($tmp), "\n";
				if ($stack->[-1] eq $tmp) {
					pop @{$stack};
				}
			}
		}	
	}
	if ($stack->[-1] eq $tag) {
		pop @{$stack};
	}
	print $out $pyx_parser->{'line'}, "\n";
}

#------------------------------------------------------------------------------
sub _final {
#------------------------------------------------------------------------------
# Process final.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	if ($#{$stack} > -1) {
		if (exists $rules->{'*'}) {
			foreach my $tmp (@{$rules->{'*'}}) {
				if ($stack->[-1] eq $tmp) {
					print $out end_tag($tmp), "\n";
				}
			}
		}

		# If set, than flush stack.
		if ($flush_stack) {
			foreach my $tmp (reverse @{$stack}) {
				print $out end_tag($tmp), "\n";
			}
		}
	}
}

1;
