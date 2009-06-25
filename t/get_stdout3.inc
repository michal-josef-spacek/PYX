# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub get_stdout3 {
#------------------------------------------------------------------------------
# Helper function.

	my ($obj, $file) = @_;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	$obj->parse_file($file);
	untie *STDOUT;

	# Output.
	return $stdout;
}
