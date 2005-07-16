# $Id: 04_comment.t,v 1.1 2005-07-16 23:42:36 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Comment writing.\n" if $debug;
#ok(go($class, "$test_dir/data/comment1.pyx"), '<!--comment-->');
#ok(go($class, "$test_dir/data/comment2.pyx"), "<!--comment\ncomment-->");

# TODO
ok(go2($class, "$test_dir/data/comment1.pyx"), '<!-- comment -->');
ok(go2($class, "$test_dir/data/comment2.pyx"), "<!-- comment\ncomment -->");

#ok(go3($class, "$test_dir/data/comment1.pyx"), '<!--comment-->');
#ok(go3($class, "$test_dir/data/comment2.pyx"), "<!--comment\ncomment-->");
