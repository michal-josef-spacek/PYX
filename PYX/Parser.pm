#------------------------------------------------------------------------------
package PYX::Parser;
#------------------------------------------------------------------------------

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;

# Version.
our $VERSION = 0.02;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Parse handlers.
	$self->{'attribute'} = '';
	$self->{'comment'} = '';
	$self->{'data'} = '';
	$self->{'end_tag'} = '';
	$self->{'final'} = '';
	$self->{'init'} = '';
	$self->{'instruction'} = '';
	$self->{'start_tag'} = '';
	$self->{'other'} = '';

	# Output rewrite.
	$self->{'output_rewrite'} = 0;

	# Output handler.
	$self->{'output_handler'} = *STDOUT;

	# Process params.
        while (@_) {
                my $key = shift;
                my $val = shift;
                err "Unknown parameter '$key'." unless exists $self->{$key};
                $self->{$key} = $val;
        }

	# Processing line.
	$self->{'line'} = '';

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx, $out) = @_;
	$out = $self->{'output_handler'} unless $out;

	# Input data.
	my @text;
	if (ref $pyx eq 'ARRAY') {
		@text = @{$pyx};
	} else {
		@text = split(/\n/, $pyx);
	}

	# Parse.
	if ($self->{'init'}) {
		&{$self->{'init'}}($self);
	}
	foreach my $line (@text) {
		$self->_parse($line, $out);
	}
	if ($self->{'final'}) {
		&{$self->{'final'}}($self);
	}
}

#------------------------------------------------------------------------------
sub parse_file {
#------------------------------------------------------------------------------
# Parse file with PYX data.

	my ($self, $input_file, $out) = @_;
	open(INF, "<$input_file");
	$self->parse_handler(\*INF, $out);
	close(INF);
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse PYX handler.

	my ($self, $input_file_handler, $out) = @_;
	err "No input handler." if ! $input_file_handler 
		|| ref $input_file_handler ne 'GLOB';
	$out = $self->{'output_handler'} unless $out;
	if ($self->{'init'}) {
		&{$self->{'init'}}($self);
	}
	while (my $line = <$input_file_handler>) {
		chomp $line;
		$self->_parse($line, $out);
	}
	if ($self->{'final'}) {
		&{$self->{'final'}}($self);
	}
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _parse {
#------------------------------------------------------------------------------
# Parse text string.

	my ($self, $line, $out) = @_;
	$self->{'line'} = $line;
	my ($type, $value) = $line =~ m/\A([A()\?\-_])(.*)\Z/;
	if (! $type) { $type = 'X'; }

	# Attribute.
	if ($type eq 'A') {
		my ($att, $attval) = $line =~ m/\AA([^\s]+)\s*(.*)\Z/;
		$self->_is_sub('attribute', $out, $att, $attval);

	# Start of tag.
	} elsif ($type eq '(') {
		$self->_is_sub('start_tag', $out, $value);

	# End of tag.
	} elsif ($type eq ')') {
		$self->_is_sub('end_tag', $out, $value);

	# Data.
	} elsif ($type eq '-') {
		$self->_is_sub('data', $out, $value);

	# Instruction.
	} elsif ($type eq '?') {
		my ($target, $data) = $line =~ m/\A\?([^\s]+)\s*(.*)\Z/;
		$self->_is_sub('instruction', $out, $target, $data);

	# Comment.
	} elsif ($type eq '_') {
		$self->_is_sub('comment', $out, $value);

	# Others.
	} else {
		if ($self->{'other'}) {
			&{$self->{'other'}}($self, $line);
		} else {
			err "Bad PYX tag at line '$line'.";
		}
	}
}

#------------------------------------------------------------------------------
sub _is_sub {
#------------------------------------------------------------------------------
# Helper to defined handlers.

	my ($self, $key, $out, @values) = @_;

	# Handler with name '$key'.
	if (exists $self->{$key} && ref $self->{$key} eq 'CODE') {
		&{$self->{$key}}($self, @values);

	# Handler rewrite.
	} elsif (exists $self->{'rewrite'} 
		&& ref $self->{'rewrite'} eq 'CODE') {

		&{$self->{'rewrite'}}($self, $self->{'line'});

	# Raw output to output handler handler.
	} elsif ($self->{'output_rewrite'}) {
		print $out $self->{'line'}, "\n";
	}
}

1;
