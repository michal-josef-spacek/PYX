# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Tag writing.\n" if $debug;
#ok(go($class, "$test_dir/data/tag1.pyx"), "<tag>\n</tag>\n");
#ok(go($class, "$test_dir/data/tag2.pyx"), "<tag par=\"val\">\n</tag>\n");
#ok(go($class, "$test_dir/data/tag3.pyx"), "<tag par=\"val\\nval\">\n</tag>\n");

# TODO
ok(go2($class, "$test_dir/data/tag1.pyx"), "<tag />");
ok(go2($class, "$test_dir/data/tag2.pyx"), "<tag par=\"val\" />");
ok(go2($class, "$test_dir/data/tag3.pyx"), "<tag par=\"val\\nval\" />");

#ok(go3($class, "$test_dir/data/tag1.pyx"), "<tag>\n</tag>\n");
#ok(go3($class, "$test_dir/data/tag2.pyx"), "<tag par=\"val\">\n</tag>\n");
#ok(go3($class, "$test_dir/data/tag3.pyx"), "<tag par=\"val\\nval\">\n</tag>\n");
