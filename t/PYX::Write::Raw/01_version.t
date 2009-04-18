# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Write::Raw::VERSION, '0.01');
