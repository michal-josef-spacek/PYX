# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Parser;
use Test::More 'tests' => 1;

# Test.
is($PYX::Parser::VERSION, 0.01, 'Version.');
