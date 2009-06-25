# Modules.
use English qw(-no_match_vars);
use IO::Scalar;

#------------------------------------------------------------------------------
sub get_stdout2 {
#------------------------------------------------------------------------------
# Helper function.

	my ($class, $file) = @_;

	# PYX::Parser object.
	my $stderr;
	tie *STDERR, 'IO::Scalar', \$stderr;
	my $obj = $class->new(
		'output_rewrite' => 1,
	);
	untie *STDERR;
	if ($stderr) {
		$stderr =~ s/(.*)\ at.*\n/$1/;
	}

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
	};
	if ($EVAL_ERROR) {
		print STDERR $EVAL_ERROR;
	}
	untie *STDOUT;
	return $stdout;
}
