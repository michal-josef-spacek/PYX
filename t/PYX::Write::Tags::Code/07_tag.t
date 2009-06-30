# Modules.
use File::Object;
use PYX::Write::Tags::Code;
use Test::More 'tests' => 4;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Tag writing.\n";
my $obj = PYX::Write::Tags::Code->new;
my $right_ret = [
	'tag',
	'end_tag',
];
get_stdout($obj, "$data_dir/tag1.pyx");
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
get_stdout($obj, "$data_dir/tag2.pyx");
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
get_stdout($obj, "$data_dir/tag3.pyx");
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
get_stdout($obj, "$data_dir/tag4.pyx");
$ret = $obj->get_tags_code(1);
is_deeply($ret, $right_ret);
