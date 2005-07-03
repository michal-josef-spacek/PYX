# $Id: 00_subs.t,v 1.2 2005-07-03 13:08:51 skim Exp $

# Modules.
use IO::Scalar;
use Tags::Running;

# Function.
sub go {
	my $class = shift;
	my $file = shift;

	# Tags::Running object.
	my $tags = Tags::Running->new(
		'set_indent' => 1,
		'data_optimalization' => 1,
	);

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse();
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}

# Function.
sub go2 {
	my $class = shift;
	my $file = shift;

	# Tags::Running object.
	my $tags = Tags::Running->new(
		'set_indent' => 1,
		'data_optimalization' => 1,
		'output_handler' => *STDERR,
	);

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse();
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	close($input_handler);
	return $stdout;
}

# Function.
sub go3 {
	my $class = shift;
	my $file = shift;

	# Tags::Running object.
	my $tags = Tags::Running->new(
		'set_indent' => 1,
		'data_optimalization' => 1,
	);

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'tags_obj' => $tags,
		'output_handler' => *STDERR,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse();
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	close($input_handler);
	return $stdout;
}
