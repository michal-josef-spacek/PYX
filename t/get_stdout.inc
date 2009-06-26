# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub get_stdout {
#------------------------------------------------------------------------------
# Helper function.

	my ($obj, $file) = @_;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
	};
	untie *STDOUT;
	return $stdout;
}
