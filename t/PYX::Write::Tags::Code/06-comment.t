# Modules.
use File::Object;
use PYX::Write::Tags::Code;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Comment writing.\n";
my $obj = PYX::Write::Tags::Code->new;
get_stdout($obj, "$data_dir/comment1.pyx");
my $ret = $obj->get_tags_code(1);
is_deeply($ret, []);

$obj = PYX::Write::Tags::Code->new;
get_stdout($obj, "$data_dir/comment2.pyx");
$ret = $obj->get_tags_code(1);
is_deeply($ret, []);
