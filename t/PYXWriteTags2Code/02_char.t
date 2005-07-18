# $Id: 02_char.t,v 1.1 2005-07-18 12:35:20 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTagsCode";

print "Testing: Char writing.\n" if $debug;
my $char = [['d', 'char']];
my $ret = go($class, "$test_dir/data/char1.pyx");
ok($ret->[0]->[0], $char->[0]->[0]);
ok($ret->[0]->[1], $char->[0]->[1]);

$char = [['d', "char\nchar"]];
$ret = go($class, "$test_dir/data/char2.pyx");
ok($ret->[0]->[0], $char->[0]->[0]);
ok($ret->[0]->[1], $char->[0]->[1]);
