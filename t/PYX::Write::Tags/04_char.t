# Modules.
use File::Object;
use PYX::Write::Tags;
use Tags::Running;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Char writing.\n";
my $tags = Tags::Running->new(
	'set_indent' => 1,
	'data_optimalization' => 1,
);
my $obj = PYX::Write::Tags->new(
	'tags_obj' => $tags,
);
ok(get_stdout($obj, "$data_dir/char1.pyx"), "char\n");
ok(get_stdout($obj, "$data_dir/char2.pyx"), "char char\n");
