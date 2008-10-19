
# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTagsCode";

print "Testing: Comment writing.\n" if $debug;
my $comment = [['c', 'comment']];
my $ret = go($class, "$test_dir/data/comment1.pyx");
ok($ret->[0]->[0], $comment->[0]->[0]);
ok($ret->[0]->[1], $comment->[0]->[1]);

$comment = [['c', "comment\ncomment"]];
$ret = go($class, "$test_dir/data/comment2.pyx");
ok($ret->[0]->[0], $comment->[0]->[0]);
ok($ret->[0]->[1], $comment->[0]->[1]);
