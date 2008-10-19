
print "Testing: instruction() function.\n" if $debug;
my $data = 'target data';
my $ret = eval $class.'::instruction($data)';
ok($ret, '?target data');

$data = "target data\ndata";
$ret = eval $class.'::instruction($data)';
ok($ret, '?target data\ndata');

