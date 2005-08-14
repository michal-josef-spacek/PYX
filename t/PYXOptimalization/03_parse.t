# $Id: 03_parse.t,v 1.1 2005-08-14 07:28:25 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXOptimalization";

print "Testing: parse() method.\n" if $debug;
my $ret = go($class, "$test_dir/data/example1.pyx");
my $right_ret = <<"END";
_comment
_comment
_comment
_comment
_comment
_comment
END
ok($ret, $right_ret);

$ret = go($class, "$test_dir/data/example2.pyx");
$right_ret = <<"END";
-data
-data
-data
-data
-data
-data
END
ok($ret, $right_ret);

$ret = go($class, "$test_dir/data/example3.pyx");
$right_ret = <<"END";
_comment
(tag
Aattr value
-data
)tag
?app vskip="10px"
END
ok($ret, $right_ret);
