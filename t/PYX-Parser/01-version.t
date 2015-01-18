# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Parser;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($PYX::Parser::VERSION, 0.03, 'Version.');
