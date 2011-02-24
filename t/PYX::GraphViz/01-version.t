# Modules.
use PYX::GraphViz;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($PYX::GraphViz::VERSION, '0.01');
