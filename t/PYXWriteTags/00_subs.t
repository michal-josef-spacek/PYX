# $Id: 00_subs.t,v 1.8 2006-02-17 13:49:37 skim Exp $

# Modules.
use IO::Scalar;
use Tags::Running;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# First version. Output is default '*STDOUT' at Tags::Running.

	my ($class, $file) = @_;

	# Tags::Running object.
	my $tags = Tags::Running->new(
		'set_indent' => 1,
		'data_optimalization' => 1,
	);

	# PYX::Write::Tags object.
	my $obj = $class->new(
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	return $stdout;
}

#------------------------------------------------------------------------------
sub go2 {
#------------------------------------------------------------------------------
# Second version. Output is Tags::Running '*STDERR'.

	my ($class, $file) = @_;

	# Tags::Running object.
	my $tags = Tags::Running->new(
		'set_indent' => 1,
		'data_optimalization' => 1,
		'output_handler' => *STDERR,
	);

	# PYX::Write::Tags object.
	my $obj = $class->new(
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	return $stdout;
}

