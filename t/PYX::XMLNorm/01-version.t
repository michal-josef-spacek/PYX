# Modules.
use PYX::XMLNorm;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: version.\n";

# Test.
is($PYX::XMLNorm::VERSION, '0.02');
