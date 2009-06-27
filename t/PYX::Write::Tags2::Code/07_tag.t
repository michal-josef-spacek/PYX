# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 3;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Tag writing.\n";
my $obj = PYX::Write::Tags2::Code->new;
my $right_ret = [
	['b', 'tag'],
	['e', 'tag'],
];
get_stdout($obj, "$test_main_dir/data/tag1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [
	['b', 'tag'],
	['a', 'par', 'val'],
	['e', 'tag'],
];
get_stdout($obj, "$test_main_dir/data/tag2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [
	['b', 'tag'],
	['a', 'par', 'val\nval'],
	['e', 'tag'],
];
get_stdout($obj, "$test_main_dir/data/tag3.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
