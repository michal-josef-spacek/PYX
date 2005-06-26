# $Id: 05_instruction.t,v 1.1 2005-06-26 16:36:08 skim Exp $

print "Testing: instruction() function.\n" if $debug;
my $target = 'target';
my $data = 'data';
my $ret = eval $class.'::instruction($target, $data)';
ok($ret, '?target data');

$data = "data\ndata";
$ret = eval $class.'::instruction($target, $data)';
ok($ret, '?target data\ndata');

