# $Id: 05_instruction.t,v 1.3 2005-08-13 20:37:54 skim Exp $

print "Testing: instruction() function.\n" if $debug;
my $data = 'target data';
my $ret = eval $class.'::instruction($data)';
ok($ret, '?target data');

$data = "target data\ndata";
$ret = eval $class.'::instruction($data)';
ok($ret, '?target data\ndata');

