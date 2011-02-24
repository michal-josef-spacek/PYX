# Modules.
use PYX::Stack;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Stack::VERSION, '0.01');
