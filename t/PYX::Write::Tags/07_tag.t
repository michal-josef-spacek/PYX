# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags;
use Test::More 'tests' => 4;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

# Modules.
use Tags::Running;

print "Testing: Tag writing.\n";
my $tags = Tags::Running->new(
	'set_indent' => 1,
	'data_optimalization' => 1,
);
my $obj = PYX::Write::Tags->new(
	'tags_obj' => $tags,
);
ok(get_stdout($obj, "$test_main_dir/data/tag1.pyx"), "<tag>\n</tag>\n");
ok(get_stdout($obj, "$test_main_dir/data/tag2.pyx"), "<tag par=\"val\">\n</tag>\n");
ok(get_stdout($obj, "$test_main_dir/data/tag3.pyx"), "<tag par=\"val\\nval\">\n</tag>\n");
ok(get_stdout($obj, "$test_main_dir/data/tag4.pyx"), 
	"<tag par1=\"val1\" par2=\"val2\">\n</tag>\n");
