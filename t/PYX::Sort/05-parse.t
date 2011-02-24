# Modules.
use File::Object;
use PYX::Sort;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: parse() method.\n";
my $obj = PYX::Sort->new;
my $ret = get_stdout($obj, "$data_dir/example6.pyx");
my $right_ret = <<"END";
(tag
Aattr1="value"
Aattr2="value"
Aattr3="value"
-text
)tag
END
is($ret, $right_ret);

$ret = get_stdout($obj, "$data_dir/example7.pyx");
is($ret, $right_ret);
