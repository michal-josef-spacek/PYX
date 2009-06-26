# Modules.
use PYX::Checker;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Checker::VERSION, '0.01');
