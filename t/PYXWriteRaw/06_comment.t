# $Id: 06_comment.t,v 1.3 2005-07-02 13:03:27 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: Comment writing.\n" if $debug;
ok(go($class, "$test_dir/data/comment1.pyx"), '<!--comment-->');
ok(go($class, "$test_dir/data/comment2.pyx"), "<!--comment\ncomment-->");

