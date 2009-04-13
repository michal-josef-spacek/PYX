# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t/";

# Modules.
use PYX::Optimalization;
use Test::More 'tests' => 4;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: parse() method.\n";
my $ret = get_stdin('PYX::Optimalization', "$test_main_dir/data/example1.pyx");
my $right_ret = <<"END";
_comment
_comment
_comment
_comment
_comment
_comment
END
is($ret, $right_ret);

$ret = get_stdin('PYX::Optimalization', "$test_main_dir/data/example2.pyx");
$right_ret = <<"END";
-data
-data
-data
-data
-data
-data
END
is($ret, $right_ret);

$ret = get_stdin('PYX::Optimalization', "$test_main_dir/data/example3.pyx");
$right_ret = <<"END";
_comment
(tag
Aattr value
-data
)tag
?app vskip="10px"
END
is($ret, $right_ret);

$ret = get_stdin('PYX::Optimalization', "$test_main_dir/data/example4.pyx");
$right_ret = <<"END";
-data data
-data data
-data data
-data data
-data data
-data data
END
is($ret, $right_ret);
