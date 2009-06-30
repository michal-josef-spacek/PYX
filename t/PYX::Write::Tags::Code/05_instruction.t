# Modules.
use File::Object;
use PYX::Write::Tags::Code;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Instruction writing.\n";
my $obj = PYX::Write::Tags::Code->new;
get_stdout($obj, $data_dir.'/instruction1.pyx');
my $ret = $obj->get_tags_code;
is_deeply($ret, []);

$obj = PYX::Write::Tags::Code->new;
get_stdout($obj, $data_dir.'/instruction1.pyx');
$ret = $obj->get_tags_code;
is_deeply($ret, []);
