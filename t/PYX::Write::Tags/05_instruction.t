# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t/PYXWriteTags";

# Modules.
use PYX::Write::Tags;
#use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Instruction writing.\n";
# TODO Cannot implemented.
# ok(go($class, "$test_main_dir/data/instruction1.pyx"), '<?target data?>');
# ok(go($class, "$test_main_dir/data/instruction2.pyx"), "<?target data\ndata?>");
