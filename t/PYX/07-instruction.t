# Pragmas.
use strict;
use warnings;

# Modules.
use PYX qw(instruction);
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $data = 'target data';
my $ret = instruction($data);
is($ret, '?target data');

# Test.
$data = "target data\ndata";
$ret = instruction($data);
is($ret, '?target data\ndata');
