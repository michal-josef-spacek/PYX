# Modules.
use File::Object;
use PYX::Write::Raw;
use Test::More 'tests' => 1;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: End tag writing.\n";
my $obj = PYX::Write::Raw->new;
my $ret = get_stdout($obj, $data_dir.'/end_tag1.pyx');
is($ret, '</tag>');
