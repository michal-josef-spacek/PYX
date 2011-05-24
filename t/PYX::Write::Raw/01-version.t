# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 1;

# Test.
is($PYX::Write::Raw::VERSION, 0.01, 'Version.');
