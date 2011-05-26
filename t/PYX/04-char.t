# Pragmas.
use strict;
use warnings;

# Modules.
use PYX qw(char);
use Test::More 'tests' => 2;

my $char = 'char';
my $ret = char($char);
is($ret, '-char');

$char = "char\nchar";
$ret = char($char);
is($ret, '-char\nchar');
