# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper function.

	my ($class, $file, $rules) = @_;

	# PYX::XMLNorm object.
	my $obj = $class->new(
		'rules' => $rules,
	);

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	$obj->parse_file($file);
	untie *STDOUT;

	# Output.
	return $stdout;
}

