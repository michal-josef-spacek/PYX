# Modules.
use File::Object;
use PYX::Write::Tags::Code;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Char writing.\n";
my $obj = PYX::Write::Tags::Code->new;
my $right_ret = [
	\'char',
];
get_stdout($obj, "$data_dir/char1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags::Code->new;
$right_ret = [
	\"char\nchar",
];
get_stdout($obj, "$data_dir/char2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
