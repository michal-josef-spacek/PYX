# $Id: 05_tag.t,v 1.1 2005-07-02 13:29:10 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Tag writing.\n" if $debug;
ok(go($class, "$test_dir/data/tag1.pyx"), "<tag>\n</tag>\n");
ok(go($class, "$test_dir/data/tag2.pyx"), "<tag par=\"val\">\n</tag>\n");
ok(go($class, "$test_dir/data/tag3.pyx"), "<tag par=\"val\\nval\">\n</tag>\n");
