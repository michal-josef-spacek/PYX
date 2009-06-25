# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Comment writing.\n";
my $ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/comment1.pyx');
is($ret, '<!--comment-->');

$ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/comment2.pyx');
is($ret, "<!--comment\ncomment-->");
