# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('PYX::Checker');
}
require_ok('PYX::Checker');
