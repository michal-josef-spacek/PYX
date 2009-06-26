# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags;
use Tags::Running;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Char writing.\n";
my $tags = Tags::Running->new(
	'set_indent' => 1,
	'data_optimalization' => 1,
);
my $obj = PYX::Write::Tags->new(
	'tags_obj' => $tags,
);
ok(get_stdout($obj, "$test_main_dir/data/char1.pyx"), "char\n");
ok(get_stdout($obj, "$test_main_dir/data/char2.pyx"), "char char\n");
