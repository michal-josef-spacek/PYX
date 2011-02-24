# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('PYX::XMLNorm');
}
require_ok('PYX::XMLNorm');
