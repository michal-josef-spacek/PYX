#------------------------------------------------------------------------------
package PYX::XMLNorm;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX qw(end_tag);
use PYX::Parser;
use PYX::Utils qw(set_params);

# Version.
our $VERSION = 0.02;

# Global variables.
use vars qw($stack $rules $flush_stack);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Flush stack on finalization.
	$self->{'flush_stack'} = 0;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# XML normalization rules.
	$self->{'rules'} = {};

	# Process params.
	set_params($self, @params);

	# Check to rules.
	if (! keys %{$self->{'rules'}}) {
		err 'Cannot exist XML normalization rules.';
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'output_handler' => $self->{'output_handler'},
		'output_rewrite' => 1,

		# Handlers.
		'data' => \&_end_tag_simple,
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
# Process start of tag.

	my ($pyx_parser, $tag) = @_;
	my $out = $pyx_parser->{'output_handler'};
	if (exists $rules->{'*'}) {
		foreach my $tmp (@{$rules->{'*'}}) {
			if (@{$stack} > 0 && lc($stack->[-1]) eq $tmp) {
				print {$out} end_tag(pop @{$stack}), "\n";
			}
		}
	}
	if (exists $rules->{lc($tag)}) {
		foreach my $tmp (@{$rules->{lc($tag)}}) {
			if (@{$stack} > 0 && lc($stack->[-1]) eq $tmp) {
				print {$out} end_tag(pop @{$stack}), "\n";
			}
		}
	}
	push @{$stack}, $tag;
	print {$out} $pyx_parser->{'line'}, "\n";
	return;
}

#------------------------------------------------------------------------------
sub _end_tag_simple {
#------------------------------------------------------------------------------
# Add implicit end_tag.

	my $pyx_parser = shift;

	# No work.
	if (! exists $rules->{'*'}) {
		return;
	}

	# Output handler.
	my $out = $pyx_parser->{'output_handler'};

	# Process.
	foreach my $tmp (@{$rules->{'*'}}) {
		if (lc $stack->[-1] eq $tmp) {
			print {$out} end_tag(pop @{$stack}), "\n";
		}
	}

	# Print line.
	print {$out} $pyx_parser->{'line'}, "\n";

	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my ($pyx_parser, $tag) = @_;
	my $out = $pyx_parser->{'output_handler'};
	if (exists $rules->{'*'}) {
		foreach my $tmp (@{$rules->{'*'}}) {
			if (lc($tag) ne $tmp && lc($stack->[-1]) eq $tmp) {
				print {$out} end_tag(pop @{$stack}), "\n";
			}
		}
	}
# XXX Myslim, ze tenhle blok je spatne.
	if (exists $rules->{$tag}) {
		foreach my $tmp (@{$rules->{$tag}}) {
			if (lc($tag) ne $tmp && lc($stack->[-1]) eq $tmp) {
				print {$out} end_tag(pop @{$stack}), "\n";
			}
		}	
	}
	if (lc($stack->[-1]) eq lc($tag)) {
		pop @{$stack};
	}
	print {$out} $pyx_parser->{'line'}, "\n";
	return;
}

#------------------------------------------------------------------------------
sub _final {
#------------------------------------------------------------------------------
# Process final.

	my $pyx_parser = shift;
	my $out = $pyx_parser->{'output_handler'};
	if (@{$stack} > 0) {

		# If set, than flush stack.
		if ($flush_stack) {
			foreach my $tmp (reverse @{$stack}) {
				print {$out} end_tag($tmp), "\n";
			}
		}
	}
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::XMLNorm - TODO

=head1 SYNOPSIS

 use PYX::XMLNorm;
 my $xml_norm = PYX::XMLNorm->new(%parameters);
 TODO

=head1 METHODS

=over 8

=item B<new()>

 Constructor.

=over 8

=item * B<flush_stack>

 TODO

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

 From PYX::Utils::set_params():
   Unknown parameter '%s'.

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use PYX::XMLNorm;

 # Object.
 my $xml_norm = PYX::XMLNorm->new(
   TODO
 );

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>,
L<PYX(3pm)>,
L<PYX::Parser(3pm)>,
L<PYX::Utils(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<skim@skim.cz>.

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.02

=cut
