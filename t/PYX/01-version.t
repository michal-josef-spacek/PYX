# Modules.
use PYX;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::VERSION, '0.04');

use FindBin qw($Bin);
print "Bin=$Bin\n";
