# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('PYX::Get');
}
require_ok('PYX::Get');
