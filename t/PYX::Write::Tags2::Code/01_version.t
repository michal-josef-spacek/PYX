# Modules.
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::Write::Tags2::Code::VERSION, '0.01');
