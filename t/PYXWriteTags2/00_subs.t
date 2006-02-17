# $Id: 00_subs.t,v 1.4 2006-02-17 13:49:38 skim Exp $

# Modules.
use IO::Scalar;
use Tags2;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# First version. Output is default '*STDOUT' at PYX::Write::Tags2.

	my ($class, $file) = @_;

	# Tags2 object.
	my $tags = Tags2->new;

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
# Second version. Output is Tags2 '*STDERR'.

	my ($class, $file) = @_;

	# Tags2 object.
	my $tags = Tags2->new(
		'output_handler' => *STDERR,
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
# Third version. Output is PYX::Write::Tags2 '*STDERR'. Tags2 output is
# default ''.

	my ($class, $file) = @_;

	# Tags2 object.
	my $tags = Tags2->new;

	# PYX::Write::Tags2 object.
	my $obj = $class->new(
		'tags_obj' => $tags,
		'output_handler' => *STDERR,
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
