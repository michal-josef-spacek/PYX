# Modules.
use PYX::Write::Tags;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Write::Tags::VERSION, '0.02');
