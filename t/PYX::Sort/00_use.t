# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('PYX::Sort');
}
require_ok('PYX::Sort');
