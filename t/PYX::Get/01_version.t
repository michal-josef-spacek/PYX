# Modules.
use PYX::Get;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Get::VERSION, '0.01');
