#------------------------------------------------------------------------------
package PYX::GraphViz;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use GraphViz;
use PYX::Parser;
use PYX::Utils qw(set_params);

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($num $object $stack);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Colors.
	$self->{'colors'} = {
		'a' => 'blue',
		'blockquote' => 'orange',
		'br' => 'orange',
		'div' => 'green',
		'form' => 'yellow',
		'html' => 'black',
		'img' => 'violet',
		'input' => 'yellow',
		'option' => 'yellow',
		'p' => 'orange',
		'select' => 'yellow',
		'table' => 'red',
		'td' => 'red',
		'textarea' => 'yellow',
		'tr' => 'red',
		'*' => 'grey',
	};

	# Layout.
	$self->{'layout'} = 'neato';

	# Height.
	$self->{'height'} = 10;
	$self->{'width'} = 10;

	# Node height.
	$self->{'node_height'} = 0.3;

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Process params.
	set_params($self, @params);

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'end_tag' => \&_end_tag,
		'final' => \&_final,
		'output_handler' => $self->{'output_handler'},
		'start_tag' => \&_start_tag,
	);

	# Check to '*' color.
	err "Bad color define for '*' tags." 
		if ! exists $self->{'colors'}->{'*'};

	# GraphViz object.
	$self->{'graphviz'} = GraphViz->new(
		'layout' => $self->{'layout'},
		'overlap' => 'scale',
		'height' => $self->{'height'},
		'width' => $self->{'width'},
	);

	# Object.
	$object = $self;

	# Number iterator.
	$num = 0;

	# Stack.
	$stack = [];

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx) = @_;
	$self->{'pyx_parser'}->parse($pyx);
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

	my ($self, $input_file_handler) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler);
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
	$num++;
	my $color;
	if (exists $object->{'colors'}->{$tag}) {
		$color = $object->{'colors'}->{$tag};
	} else {
		$color = $object->{'colors'}->{'*'};
	}
	$object->{'graphviz'}->add_node($num, 
		'color' => $color, 
		'height' => $object->{'node_height'},
		'shape' => 'point'
	);
	$object->{'graphviz'}->add_edge(
		$num => $stack->[-1]->[1], 
		'arrowhead' => 'none',
		'weight' => 2,
	) if $#{$stack} > -1;
	push @{$stack}, [$tag, $num];
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my ($pyx_parser_obj, $tag) = @_;
	if ($stack->[-1]->[0] eq $tag) {
		pop @{$stack};
	}
	return;
}

#------------------------------------------------------------------------------
sub _final {
#------------------------------------------------------------------------------
# Final.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	$object->{'graphviz'}->as_png($out);
	return;
}

1;

=pod

=head1 NAME

PYX::GraphViz - TODO

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

TODO

=head1 METHODS

=over 8

=item B<new()>

TODO

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

TODO

=head1 REQUIREMENTS

L<Error::Simple::Multiple>,
L<GraphViz>,
L<PYX::Parser>
L<PYX::Utils>

=head1 AUTHOR

Michal Spacek L<tupinek@gmail.com>

=head1 VERSION

0.01

=cut
