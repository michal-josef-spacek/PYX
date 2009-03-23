# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags2";

print "Testing: Comment writing.\n" if $debug;
#ok(go($class, "$test_dir/data/comment1.pyx"), '<!--comment-->');
#ok(go($class, "$test_dir/data/comment2.pyx"), "<!--comment\ncomment-->");

ok(go2($class, "$test_dir/data/comment1.pyx"), '<!--comment-->');
ok(go2($class, "$test_dir/data/comment2.pyx"), "<!--comment\ncomment-->");

#ok(go3($class, "$test_dir/data/comment1.pyx"), '<!--comment-->');
#ok(go3($class, "$test_dir/data/comment2.pyx"), "<!--comment\ncomment-->");
