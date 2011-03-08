# Modules.
use Test::More 'tests' => 2;

BEGIN {

	# Debug message.
	print "Usage tests.\n";

	# Test.
	use_ok('PYX::XMLNorm');
}

# Test.
require_ok('PYX::XMLNorm');
