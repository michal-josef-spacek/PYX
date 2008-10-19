
# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTagsCode";

print "Testing: Char writing.\n" if $debug;
my $char = [
	\'char',
];
my $ret = go($class, "$test_dir/data/char1.pyx");
ok(${$ret->[0]}, ${$char->[0]});

$char = [
	\"char\nchar",
];
$ret = go($class, "$test_dir/data/char2.pyx");
ok(${$ret->[0]}, ${$char->[0]});
