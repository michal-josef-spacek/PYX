# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('PYX::Write::Tags');
}
require_ok('PYX::Write::Tags');
