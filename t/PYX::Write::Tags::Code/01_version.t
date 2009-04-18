# Modules.
use PYX::Write::Tags::Code;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Write::Tags::Code::VERSION, '0.01');
