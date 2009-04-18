# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub get_stdin {
#------------------------------------------------------------------------------
# Helper function.

	my ($class, $file) = @_;

	# Object.
	my $obj = $class->new;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	$obj->parse_file($file);
	untie *STDOUT;

	# Output.
	return $stdout;
}
