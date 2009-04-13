# Modules.
use PYX::Parser;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Parser::VERSION, '0.02');
