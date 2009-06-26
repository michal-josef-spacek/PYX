# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Tags2;
use Tags2::Output::Raw;
use Test::More 'tests' => 3;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Tag writing.\n";
my $tags2 = Tags2::Output::Raw->new(
	'xml' => 1,
);
my $obj = PYX::Write::Tags2->new(
	'tags_obj' => $tags2,
);
get_stdout($obj, "$test_main_dir/data/tag1.pyx");
is($tags2->flush, "<tag />");

$tags2->reset;
get_stdout($obj, "$test_main_dir/data/tag2.pyx");
is($tags2->flush, "<tag par=\"val\" />");

$tags2->reset;
get_stdout($obj, "$test_main_dir/data/tag3.pyx");
is($tags2->flush, "<tag par=\"val\\nval\" />");
