#------------------------------------------------------------------------------
package PYX::Parser;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);

# Version.
our $VERSION = 0.02;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
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
	if (! $out) {
		$out = $self->{'output_handler'};
	}

	# Input data.
	my @text;
	if (ref $pyx eq 'ARRAY') {
		@text = @{$pyx};
	} else {
		@text = split /\n/ms, $pyx;
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
	open my $inf , '<', $input_file;
	$self->parse_handler($inf, $out);
	close $inf;
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse PYX handler.

	my ($self, $input_file_handler, $out) = @_;
	if (! $input_file_handler || ref $input_file_handler ne 'GLOB') {
		err 'No input handler.';
	}
	if (! $out) {
		$out = $self->{'output_handler'};
	}
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
	if (! $type) { 
		$type = 'X';
	}

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
		print {$out} $self->{'line'}, "\n";
	}
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Parser - TODO

=head1 SYNOPSIS

TODO

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<attribute>

TODO

=item * B<comment>

TODO

=item * B<data>

TODO

=item * B<end_tag>

TODO

=item * B<final>

TODO

=item * B<init>

TODO

=item * B<instruction>

TODO

=item * B<start_tag>

TODO

=item * B<output_rewrite>

TODO

=item * B<output_handler>

TODO

=item * B<other>

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
 use PYX::Parser;

 # PYX::Parser object.
 my $pyx = PYX::Parser->new(
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

0.02

=cut
