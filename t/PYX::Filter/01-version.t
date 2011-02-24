# Modules.
use PYX::Filter;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Filter::VERSION, '0.01');
