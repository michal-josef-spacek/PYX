# Modules.
use PYX::XMLNorm;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::XMLNorm::VERSION, '0.02');
