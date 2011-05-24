# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Write::Tags::Code;
use Test::More 'tests' => 1;

# Test.
is($PYX::Write::Tags::Code::VERSION, 0.01, 'Version.');
