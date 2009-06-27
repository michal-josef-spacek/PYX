# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Instruction writing.\n";
my $obj = PYX::Write::Tags2::Code->new;
my $right_ret = [['i', 'target', 'code']];
get_stdout($obj, "$test_main_dir/data/instruction1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [['i', 'target', 'data\ndata']];
get_stdout($obj, "$test_main_dir/data/instruction2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
