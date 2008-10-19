
# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTagsCode";

print "Testing: Tag writing.\n" if $debug;
my $tag = [['b', 'tag'], ['e', 'tag']];
my $ret = go($class, "$test_dir/data/tag1.pyx");
ok($ret->[0]->[0], $tag->[0]->[0]);
ok($ret->[0]->[1], $tag->[0]->[1]);
ok($ret->[1]->[1], $tag->[1]->[1]);
ok($ret->[1]->[1], $tag->[1]->[1]);

$tag = [['b', 'tag'], ['a', 'par', 'val'], ['e', 'tag']];
$ret = go($class, "$test_dir/data/tag2.pyx");
ok($ret->[0]->[0], $tag->[0]->[0]);
ok($ret->[0]->[1], $tag->[0]->[1]);
ok($ret->[1]->[0], $tag->[1]->[0]);
ok($ret->[1]->[1], $tag->[1]->[1]);
ok($ret->[1]->[2], $tag->[1]->[2]);
ok($ret->[2]->[0], $tag->[2]->[0]);
ok($ret->[2]->[1], $tag->[2]->[1]);

$tag = [['b', 'tag'], ['a', 'par', 'val\nval'], ['e', 'tag']];
$ret = go($class, "$test_dir/data/tag3.pyx");
ok($ret->[0]->[0], $tag->[0]->[0]);
ok($ret->[0]->[1], $tag->[0]->[1]);
ok($ret->[1]->[0], $tag->[1]->[0]);
ok($ret->[1]->[1], $tag->[1]->[1]);
ok($ret->[1]->[2], $tag->[1]->[2]);
ok($ret->[2]->[0], $tag->[2]->[0]);
ok($ret->[2]->[1], $tag->[2]->[1]);
