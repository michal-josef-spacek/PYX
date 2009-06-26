# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags2;
use Tags2::Output::Raw;
use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Comment writing.\n";
my $tags2 = Tags2::Output::Raw->new(
	'xml' => 1,
);
my $obj = PYX::Write::Tags2->new(
	'tags_obj' => $tags2,
);
get_stdout($obj, "$test_main_dir/data/comment1.pyx");
is($tags2->flush, '<!--comment-->');

$tags2->reset;
get_stdout($obj, "$test_main_dir/data/comment2.pyx");
is($tags2->flush, "<!--comment\ncomment-->");
