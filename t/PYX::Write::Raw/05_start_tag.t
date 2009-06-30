# Modules.
use File::Object;
use PYX::Write::Raw;
use Test::More 'tests' => 3;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Start tag writing.\n";
my $obj = PYX::Write::Raw->new;
my $ret = get_stdout($obj, $data_dir.'/start_tag1.pyx');
is($ret, '<tag');

$obj = PYX::Write::Raw->new;
$ret = get_stdout($obj, $data_dir.'/start_tag2.pyx');
is($ret, '<tag par="val"');

$obj = PYX::Write::Raw->new;
$ret = get_stdout($obj, $data_dir.'/start_tag3.pyx');
is($ret, '<tag par="val\nval"');
