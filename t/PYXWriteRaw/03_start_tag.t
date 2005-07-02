# $Id: 03_start_tag.t,v 1.4 2005-07-02 13:16:12 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: Start tag writing.\n" if $debug;
ok(go($class, "$test_dir/data/start_tag1.pyx"), '<tag');
ok(go($class, "$test_dir/data/start_tag2.pyx"), '<tag par="val"');
ok(go($class, "$test_dir/data/start_tag3.pyx"), '<tag par="val\nval"');
