# Modules.
use File::Object;
use PYX::Write::Raw;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Char writing.\n";
my $obj = PYX::Write::Raw->new;
my $ret = get_stdout($obj, $data_dir.'/char1.pyx');
is($ret, 'char');

$ret = get_stdout($obj, $data_dir.'/char2.pyx');
is($ret, "char\nchar");
