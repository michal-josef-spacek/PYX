# Modules.
use IO::Scalar;
use Tags2::Output::Indent;
use Tags2::Output::Raw;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# First version. Output is default '*STDOUT' at PYX::Write::Tags2.

	my ($class, $file) = @_;

	# Tags2 object.
	my $tags = Tags2::Output::Raw->new(
		'xml' => 1,
	);

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
		$tags->flush;
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
# Second version. Output is Tags2::Output::Indent '*STDERR'.

	my ($class, $file) = @_;

	# Tags2 object.
	my $tags = Tags2::Output::Raw->new(
		'output_handler' => \*STDERR,
		'xml' => 1,
	);

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
		$tags->flush;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	return $stdout;
}

#------------------------------------------------------------------------------
sub go3 {
#------------------------------------------------------------------------------
# Third version. Output is PYX::Write::Tags2 '*STDERR'. Tags2::Output::Indent 
# output is default ''.

	my ($class, $file) = @_;

	# Tags2 object.
	my $tags = Tags2::Output::Indent->new(
		'xml' => 1,
	);

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'tags_obj' => $tags,
		'output_handler' => \*STDERR,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
		$tags->flush;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	return $stdout;
}
