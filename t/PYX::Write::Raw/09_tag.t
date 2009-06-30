# Modules.
use File::Object;
use PYX::Write::Raw;
use Test::More 'tests' => 3;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Tag writing.\n";
my $obj = PYX::Write::Raw->new;
my $ret = get_stdout($obj, $data_dir.'/tag1.pyx');
is($ret, '<tag></tag>');

$ret = get_stdout($obj, $data_dir.'/tag2.pyx');
is($ret, '<tag par="val"></tag>');

$ret = get_stdout($obj, $data_dir.'/tag3.pyx');
is($ret, '<tag par="val\nval"></tag>');
