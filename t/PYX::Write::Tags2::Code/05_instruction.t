# Modules.
use File::Object;
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Instruction writing.\n";
my $obj = PYX::Write::Tags2::Code->new;
my $right_ret = [['i', 'target', 'code']];
get_stdout($obj, "$data_dir/instruction1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [['i', 'target', 'data\ndata']];
get_stdout($obj, "$data_dir/instruction2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
