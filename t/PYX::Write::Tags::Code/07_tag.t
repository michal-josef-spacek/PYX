# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags::Code;
use Test::More 'tests' => 4;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Tag writing.\n";
my $obj = PYX::Write::Tags::Code->new;
my $right_ret = [
	'tag',
	'end_tag',
];
get_stdout($obj, "$test_main_dir/data/tag1.pyx");
my $ret = $obj->get_tags_code(1);
is_deeply($ret, $right_ret);

$right_ret = [
	'tag',
	[
		'par',
		'val',
	],
	'end_tag',
];
get_stdout($obj, "$test_main_dir/data/tag2.pyx");
$ret = $obj->get_tags_code(1);
is_deeply($ret, $right_ret);

$right_ret = [
	'tag',
	[
		'par',
		'val\nval',
	],
	'end_tag',
];
get_stdout($obj, "$test_main_dir/data/tag3.pyx");
$ret = $obj->get_tags_code(1);
is_deeply($ret, $right_ret);

$right_ret = [
	'tag',
	[
		'par1',
		'val1',
		'par2',
		'val2',
	],
	'end_tag',
];
get_stdout($obj, "$test_main_dir/data/tag4.pyx");
$ret = $obj->get_tags_code(1);
is_deeply($ret, $right_ret);
