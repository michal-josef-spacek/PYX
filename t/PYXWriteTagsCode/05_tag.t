# $Id: 05_tag.t,v 1.1 2005-07-13 14:10:10 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTagsCode";

print "Testing: Tag writing.\n" if $debug;
my $tag = [
	'tag',
	'end_tag',
];
my $ret = go($class, "$test_dir/data/tag1.pyx");
ok($ret->[0], $tag->[0]);
ok($ret->[1], $tag->[1]);

$tag = [
	'tag',
	[
		'par',
		'val',
	],
	'end_tag',
];
$ret = go($class, "$test_dir/data/tag2.pyx");
ok($ret->[0], $tag->[0]);
ok($ret->[1]->[0], $tag->[1]->[0]);
ok($ret->[1]->[1], $tag->[1]->[1]);
ok($ret->[2], $tag->[2]);

$tag = [
	'tag',
	[
		'par',
		'val\nval',
	],
	'end_tag',
];
$ret = go($class, "$test_dir/data/tag3.pyx");
ok($ret->[0], $tag->[0]);
ok($ret->[1]->[0], $tag->[1]->[0]);
ok($ret->[1]->[1], $tag->[1]->[1]);
ok($ret->[2], $tag->[2]);

