# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Checker;
use Test::More 'tests' => 1;

# Test.
is($PYX::Checker::VERSION, 0.01, 'Version.');
