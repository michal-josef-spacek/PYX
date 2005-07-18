# $Id: 03_instruction.t,v 1.1 2005-07-18 12:35:20 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTagsCode";

print "Testing: Instruction writing.\n" if $debug;
my $instruction = [['i', 'target', 'data']];
my $ret = go($class, "$test_dir/data/instruction1.pyx");
ok($ret->[0]->[0], $instruction->[0]->[0]);
ok($ret->[0]->[1], $instruction->[0]->[1]);
ok($ret->[0]->[2], $instruction->[0]->[2]);

$instruction = [['i', 'target', 'data\ndata']];
$ret = go($class, "$test_dir/data/instruction2.pyx");
ok($ret->[0]->[0], $instruction->[0]->[0]);
ok($ret->[0]->[1], $instruction->[0]->[1]);
ok($ret->[0]->[2], $instruction->[0]->[2]);
