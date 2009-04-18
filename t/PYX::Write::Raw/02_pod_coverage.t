# Modules.
use Test::Pod::Coverage 'tests' => 1;

print "Testing: Pod coverage.\n";
pod_coverage_ok('PYX::Write::Raw', 'PYX::Write::Raw is covered.');
