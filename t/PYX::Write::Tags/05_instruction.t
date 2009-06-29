# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags;
use Tags::Running;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Instruction writing.\n";
my $tags = Tags::Running->new;
my $obj = PYX::Write::Tags->new(
	'tags_obj' => $tags,
);
is(get_stdout($obj, "$test_main_dir/data/instruction1.pyx"), undef);
is(get_stdout($obj, "$test_main_dir/data/instruction2.pyx"), undef);