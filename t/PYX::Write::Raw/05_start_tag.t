# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 3;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Start tag writing.\n";
my $obj = PYX::Write::Raw->new;
my $ret = get_stdout($obj, $test_main_dir.'/data/start_tag1.pyx');
is($ret, '<tag');

$obj = PYX::Write::Raw->new;
$ret = get_stdout($obj, $test_main_dir.'/data/start_tag2.pyx');
is($ret, '<tag par="val"');

$obj = PYX::Write::Raw->new;
$ret = get_stdout($obj, $test_main_dir.'/data/start_tag3.pyx');
is($ret, '<tag par="val\nval"');
