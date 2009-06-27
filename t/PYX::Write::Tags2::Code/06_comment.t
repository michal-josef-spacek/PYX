# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Comment writing.\n";
my $obj = PYX::Write::Tags2::Code->new;
my $right_ret = [['c', 'comment']];
get_stdout($obj, "$test_main_dir/data/comment1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [['c', "comment\ncomment"]];
get_stdout($obj, "$test_main_dir/data/comment2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
