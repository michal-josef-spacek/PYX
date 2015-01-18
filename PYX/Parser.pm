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
our $VERSION = 0.02;

# Constructor.
sub new {
	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Parse callbacks.
	$self->{'callbacks'} = {
		'attribute' => undef,
		'comment' => undef,
		'data' => undef,
		'end_tag' => undef,
		'final' => undef,
		'init' => undef,
		'instruction' => undef,
		'rewrite' => undef,
		'start_tag' => undef,
		'other' => undef,
	},

	# Non parser options.
	$self->{'non_parser_options'} = {};

	# Output rewrite.
	$self->{'output_rewrite'} = 0;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Process params.
	set_params($self, @params);

	# Check output handler.
	if (defined $self->{'output_handler'}
		&& ref $self->{'output_handler'} ne 'GLOB') {

		err 'Bad output handler.';
	}

	# Processing line.
	$self->{'_line'} = $EMPTY_STR;

	# Object.
	return $self;
}

# Parse PYX text or array of PYX text.
sub parse {
	my ($self, $pyx, $out) = @_;
	if (! defined $out) {
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
	if ($self->{'callbacks'}->{'init'}) {
		&{$self->{'callbacks'}->{'init'}}($self);
	}
	foreach my $line (@text) {
		$self->_parse($line, $out);
	}
	if ($self->{'callbacks'}->{'final'}) {
		&{$self->{'callbacks'}->{'final'}}($self);
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
	if (! defined $out) {
		$out = $self->{'output_handler'};
	}
	if ($self->{'callbacks'}->{'init'}) {
		&{$self->{'callbacks'}->{'init'}}($self);
	}
	while (my $line = <$input_file_handler>) {
		chomp $line;
		$self->_parse($line, $out);
	}
	if ($self->{'callbacks'}->{'final'}) {
		&{$self->{'callbacks'}->{'final'}}($self);
	}
	return;
}

# Parse text string.
sub _parse {
	my ($self, $line, $out) = @_;
	$self->{'_line'} = $line;
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
		if ($self->{'callbacks'}->{'other'}) {
			&{$self->{'callbacks'}->{'other'}}($self, $line);
		} else {
			err "Bad PYX tag at line '$line'.";
		}
	}
	return;
}

# Helper to defined callbacks.
sub _is_sub {
	my ($self, $key, $out, @values) = @_;

	# Callback with name '$key'.
	if (exists $self->{'callbacks'}->{$key}
		&& ref $self->{'callbacks'}->{$key} eq 'CODE') {

		&{$self->{'callbacks'}->{$key}}($self, @values);

	# Rewrite callback.
	} elsif (exists $self->{'callbacks'}->{'rewrite'} 
		&& ref $self->{'callbacks'}->{'rewrite'} eq 'CODE') {

		&{$self->{'callbacks'}->{'rewrite'}}($self, $self->{'_line'});

	# Raw output to output file handler.
	} elsif ($self->{'output_rewrite'}) {
		print {$out} $self->{'_line'}, "\n";
	}
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

PYX::Parser - PYX parser with callbacks.

=head1 SYNOPSIS

 use PYX::Parser;
 my $obj = PYX::Parser->new(%parameters);
 $obj->parse($pyx, $out);
 $obj->parse_file($input_file, $out);
 $obj->parse_handle($input_file_handler, $out);

=head1 METHODS

=over 8

=item C<new(%parameters)>

 Constructor.

=over 8

=item * C<callbacks>

 Callbacks.

=over 8

=item * C<attribute>

 Attribute callback.
 Default value is undef.

=item * C<comment>

 Comment callback.
 Default value is undef.

=item * C<data>

 Data callback.
 Default value is undef.

=item * C<end_tag>

 End of tag callback.
 Default value is undef.

=item * C<final>

 Final callback.
 Default value is undef.

=item * C<init>

 Init callback.
 Default value is undef.

=item * C<instruction>

 Instruction callback.
 Default value is undef.

=item * C<rewrite>

 Rewrite callback.
 Callback is used on every line.
 Default value is undef.

=item * C<start_tag>

 Start of tag callback.
 Default value is undef.

=item * C<other>

 Other Callback.
 Default value is undef.

=back

=item * C<non_parser_options>

 Non parser options.
 Default value is blank reference to hash.

=item * C<output_rewrite>

 Output rewrite.
 Default value is 0.

=item * C<output_handler>

 Output handler.
 Default value is \*STDOUT.

=back

=item C<parse($pyx[, $out])>

 Parse PYX text or array of PYX text.
 If $out not present, use 'output_handler'.
 Returns undef.

=item C<parse_file($input_file[, $out])>

 Parse file with PYX data.
 If $out not present, use 'output_handler'.
 Returns undef.

=item C<parse_handler($input_file_handler[, $out])>

 Parse PYX handler.
 If $out not present, use 'output_handler'.
 Returns undef.

=back

=head1 ERRORS

 new():
         Bad output handler.
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
	'callbacks' => {
        	'start_tag' => \&start_tag,
        	'end_tag' => \&end_tag,
	},
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
        return;
 }

 # End tag handler.
 sub end_tag {
        my ($self, $tag) = @_;
        print "End of tag '$tag'.\n";
        return;
 }

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>.

=head1 SEE ALSO

L<PYX>,
L<PYX::Utils>.

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

 © 2005-2015 Michal Špaček
 BSD 2-Clause License

=head1 VERSION

0.02

=cut
