# $Id: 00_subs.t,v 1.2 2005-08-14 18:29:39 skim Exp $

# Modules.
use IO::Scalar;
use Tags2;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# First version. Output is default '*STDOUT' at PYX::Write::Tags2.

	my $class = shift;
	my $file = shift;

	# Tags2 object.
	my $tags = Tags2->new;

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse;
		$tags->flush;
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
# Second version. Output is Tags2 '*STDERR'.

	my $class = shift;
	my $file = shift;

	# Tags2 object.
	my $tags = Tags2->new(
		'output_handler' => *STDERR,
	);

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'tags_obj' => $tags,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse;
		$tags->flush;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	close($input_handler);
	return $stdout;
}

#------------------------------------------------------------------------------
sub go3 {
#------------------------------------------------------------------------------
# Third version. Output is PYX::Write::Tags2 '*STDERR'. Tags2 output is
# default ''.

	my $class = shift;
	my $file = shift;

	# Tags2 object.
	my $tags = Tags2->new;

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'tags_obj' => $tags,
		'output_handler' => *STDERR,
	);

	# Parse example.
	my $stdout;
	tie *STDERR, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse;
		$tags->flush;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDERR;
	close($input_handler);
	return $stdout;
}
