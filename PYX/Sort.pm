#------------------------------------------------------------------------------
package PYX::Sort;
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
our $TAG;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Process params.
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		if (! exists $self->{$key}) {
			err "Unknown parameter '$key'.";
		}
		$self->{$key} = $val;
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'output_handler' => $self->{'output_handler'},
		'attribute' => \&_attribute,
		'start_tag' => \&_tag,
		'end_tag' => \&_tag,
		'comment' => \&_tag,
		'instruction' => \&_tag,
		'data' => \&_tag,
	);

	# Tag values.
	$TAG = {};

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
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	my ($pyx_parser_obj, $att, $attval) = @_;
	$TAG->{$att} = $attval;
	return;
}

#------------------------------------------------------------------------------
sub _tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	_flush($pyx_parser_obj);
	print {$out} $pyx_parser_obj->{'line'}, "\n";
	return;
}

#------------------------------------------------------------------------------
sub _flush {
#------------------------------------------------------------------------------
# Flush attributes.

	my $pyx_parser_obj = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if (scalar %{$TAG}) {
		foreach my $key (sort keys %{$TAG}) {
			print {$out} 'A'.$key.'="'.$TAG->{$key}.'"'."\n";
		}
		$TAG = {};
	}
	return;
}

1;
