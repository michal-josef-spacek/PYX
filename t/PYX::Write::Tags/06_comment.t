# Modules.
use File::Object;
use PYX::Write::Tags;
use Tags::Running;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Comment writing.\n";
my $tags = Tags::Running->new;
my $obj = PYX::Write::Tags->new(
	'tags_obj' => $tags,
);
is(get_stdout($obj, "$data_dir/comment1.pyx"), undef);
is(get_stdout($obj, "$data_dir/comment2.pyx"), undef);
