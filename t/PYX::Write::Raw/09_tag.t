# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 3;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Tag writing.\n";
my $ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/tag1.pyx');
is($ret, '<tag></tag>');

$ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/tag2.pyx');
is($ret, '<tag par="val"></tag>');

$ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/tag3.pyx');
is($ret, '<tag par="val\nval"></tag>');
