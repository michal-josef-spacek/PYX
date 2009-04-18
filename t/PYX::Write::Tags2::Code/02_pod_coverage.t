# Modules.
use Test::Pod::Coverage 'tests' => 1;

print "Testing: Pod coverage.\n";
pod_coverage_ok('PYX::Write::Tags2::Code', 
	'PYX::Write::Tags2::Code is covered.');
