# Modules.
use File::Object;
use PYX::Write::Tags2::Code;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Comment writing.\n";
my $obj = PYX::Write::Tags2::Code->new;
my $right_ret = [['c', 'comment']];
get_stdout($obj, "$data_dir/comment1.pyx");
my $ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);

$obj = PYX::Write::Tags2::Code->new;
$right_ret = [['c', "comment\ncomment"]];
get_stdout($obj, "$data_dir/comment2.pyx");
$ret = $obj->get_tags_code;
is_deeply($ret, $right_ret);
