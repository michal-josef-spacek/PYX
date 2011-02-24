# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('PYX::GraphViz');
}
require_ok('PYX::GraphViz');
