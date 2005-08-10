# $Id: 03_parse.t,v 1.1 2005-08-10 14:55:01 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXSort";

print "Testing: parse() method.\n" if $debug;
my $ret = go($class, "$test_dir/data/example1.pyx");
my $right_ret = <<"END";
(tag
Aattr1="value"
Aattr2="value"
Aattr3="value"
-text
)tag
END
ok($ret, $right_ret);

$ret = go($class, "$test_dir/data/example2.pyx");
ok($ret, $right_ret);
