# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags::Code;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Comment writing.\n";
my $obj = PYX::Write::Tags::Code->new;
get_stdout($obj, "$test_main_dir/data/comment1.pyx");
my $ret = $obj->get_tags_code(1);
is_deeply($ret, []);

$obj = PYX::Write::Tags::Code->new;
get_stdout($obj, "$test_main_dir/data/comment2.pyx");
$ret = $obj->get_tags_code(1);
is_deeply($ret, []);
