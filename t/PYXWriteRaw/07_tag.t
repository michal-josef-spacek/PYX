# $Id: 07_tag.t,v 1.2 2005-07-02 13:16:12 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: Tag writing.\n" if $debug;
ok(go($class, "$test_dir/data/tag1.pyx"), '<tag></tag>');
ok(go($class, "$test_dir/data/tag2.pyx"), '<tag par="val"></tag>');
ok(go($class, "$test_dir/data/tag3.pyx"), '<tag par="val\nval"></tag>');
