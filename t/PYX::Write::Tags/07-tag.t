# Modules.
use File::Object;
use PYX::Write::Tags;
use Tags::Running;
use Test::More 'tests' => 4;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Tag writing.\n";
my $tags = Tags::Running->new(
	'set_indent' => 1,
	'data_optimalization' => 1,
);
my $obj = PYX::Write::Tags->new(
	'tags_obj' => $tags,
);
ok(get_stdout($obj, "$data_dir/tag1.pyx"), "<tag>\n</tag>\n");
ok(get_stdout($obj, "$data_dir/tag2.pyx"), "<tag par=\"val\">\n</tag>\n");
ok(get_stdout($obj, "$data_dir/tag3.pyx"), "<tag par=\"val\\nval\">\n</tag>\n");
ok(get_stdout($obj, "$data_dir/tag4.pyx"), 
	"<tag par1=\"val1\" par2=\"val2\">\n</tag>\n");
