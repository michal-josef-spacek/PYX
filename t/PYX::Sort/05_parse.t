# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Sort;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdin.inc';

print "Testing: parse() method.\n";
my $ret = get_stdin('PYX::Sort', "$test_main_dir/data/example6.pyx");
my $right_ret = <<"END";
(tag
Aattr1="value"
Aattr2="value"
Aattr3="value"
-text
)tag
END
is($ret, $right_ret);

$ret = get_stdin('PYX::Sort', "$test_main_dir/data/example7.pyx");
is($ret, $right_ret);
