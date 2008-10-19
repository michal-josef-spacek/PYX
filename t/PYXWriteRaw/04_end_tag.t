
# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: End tag writing.\n" if $debug;
ok(go($class, "$test_dir/data/end_tag1.pyx"), '</tag>');
