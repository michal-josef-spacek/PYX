# Modules.
use File::Object;
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 3;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Tag writing.\n";
my $obj = PYX::Write::Tags2::Code->new;
my $right_ret = [
	['b', 'tag'],
	['e', 'tag'],
];
get_stdout($obj, "$data_dir/tag1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [
	['b', 'tag'],
	['a', 'par', 'val'],
	['e', 'tag'],
];
get_stdout($obj, "$data_dir/tag2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [
	['b', 'tag'],
	['a', 'par', 'val\nval'],
	['e', 'tag'],
];
get_stdout($obj, "$data_dir/tag3.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
