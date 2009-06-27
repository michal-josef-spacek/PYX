# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags::Code;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Char writing.\n";
my $obj = PYX::Write::Tags::Code->new;
my $right_ret = [
	\'char',
];
get_stdout($obj, "$test_main_dir/data/char1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags::Code->new;
$right_ret = [
	\"char\nchar",
];
get_stdout($obj, "$test_main_dir/data/char2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
