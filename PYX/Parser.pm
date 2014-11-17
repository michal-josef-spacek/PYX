package PYX::Parser;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Readonly;

# Constants.
Readonly::Scalar my $EMPTY_STR => q{};

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Parse handlers.
	$self->{'attribute'} = undef;
	$self->{'comment'} = undef;
	$self->{'data'} = undef;
	$self->{'end_tag'} = undef;
	$self->{'final'} = undef;
	$self->{'init'} = undef;
	$self->{'instruction'} = undef;
	$self->{'start_tag'} = undef;
	$self->{'other'} = undef;

	# Output rewrite.
	$self->{'output_rewrite'} = 0;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Process params.
	set_params($self, @params);

	# Processing line.
	$self->{'line'} = $EMPTY_STR;

	# Object.
	return $self;
}

# Parse PYX text or array of PYX text.
sub parse {
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
	return;
}

# Parse file with PYX data.
sub parse_file {
	my ($self, $input_file, $out) = @_;
	open my $inf, '<', $input_file;
	$self->parse_handler($inf, $out);
	close $inf;
	return;
}

# Parse PYX handler.
sub parse_handler {
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
	return;
}

# Parse text string.
sub _parse {
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
	return;
}

# Helper to defined handlers.
sub _is_sub {
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
	return;
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

=item C<new(%parameters)>

 Constructor.

=over 8

=item * C<attribute>

TODO

=item * C<comment>

TODO

=item * C<data>

TODO

=item * C<end_tag>

TODO

=item * C<final>

TODO

=item * C<init>

TODO

=item * C<instruction>

TODO

=item * C<start_tag>

TODO

=item * C<output_rewrite>

TODO

=item * C<output_handler>

TODO

=item * C<other>

TODO

=back

=item C<parse()>

TODO

=item C<parse_file()>

TODO

=item C<parse_handler()>

TODO

=back

=head1 ERRORS

 new():
         From Class::Utils::set_params():
                 Unknown parameter '%s'.

 parse():
         Bad PYX tag at line '%s'.

 parse_file():
         Bad PYX tag at line '%s'.
         No input handler.

 parse_handler():
         Bad PYX tag at line '%s'.
         No input handler.

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;
 
 # Modules.
 use PYX::Parser;
 
 # Open file.
 my $file_handler = \*STDIN;
 my $file = $ARGV[0];
 if ($file) {
        if (! open(INF, '<', $file)) {
                die "Cannot open file '$file'.";
        }
        $file_handler = \*INF;
 }
 
 # PYX::Parser object.
 my $parser = PYX::Parser->new(
        'start_tag' => \&start_tag,
        'end_tag' => \&end_tag,
 );
 $parser->parse_handler($file_handler);
 
 # Close file.
 if ($file) {
        close(INF);
 }
 
 # Start tag handler.
 sub start_tag {
        my ($self, $tag) = @_;
        print "Start of tag '$tag'.\n";
 }

 # End tag handler.
 sub end_tag {
        my ($self, $tag) = @_;
        print "End of tag '$tag'.\n";
 }

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>.

=head1 SEE ALSO

TODO

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>.

=head1 LICENSE AND COPYRIGHT

BSD 2-Clause License

=head1 VERSION

0.01

=cut
