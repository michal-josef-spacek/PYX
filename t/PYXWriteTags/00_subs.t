# $Id: 00_subs.t,v 1.6 2005-11-14 15:58:38 skim Exp $

# Modules.
use IO::Scalar;
use Tags::Running;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# First version. Output is default '*STDOUT' at Tags::Running.

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
		$obj->parse;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}

#------------------------------------------------------------------------------
sub go2 {
#------------------------------------------------------------------------------
# Second version. Output is Tags::Running '*STDERR'.

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
		$obj->parse;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	close($input_handler);
	return $stdout;
}

