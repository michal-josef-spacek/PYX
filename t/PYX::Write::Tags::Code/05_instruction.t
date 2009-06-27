# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags::Code;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Instruction writing.\n";
my $obj = PYX::Write::Tags::Code->new;
get_stdout($obj, $test_main_dir.'/data/instruction1.pyx');
my $ret = $obj->get_tags_code;
is_deeply($ret, []);

$obj = PYX::Write::Tags::Code->new;
get_stdout($obj, $test_main_dir.'/data/instruction1.pyx');
$ret = $obj->get_tags_code;
is_deeply($ret, []);
