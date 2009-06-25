# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Instruction writing.\n";
my $ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/instruction1.pyx');
is($ret, '<?target data?>');

$ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/instruction2.pyx');
is($ret, "<?target data\ndata?>");
