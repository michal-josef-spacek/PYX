print "Testing: char() function.\n" if $debug;
my $char = 'char';
my $ret = eval $class.'::char($char)';
ok($ret, '-char');

$char = "char\nchar";
$ret = eval $class.'::char($char)';
ok($ret, '-char\nchar');
