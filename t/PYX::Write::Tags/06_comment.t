# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t/PYXWriteTags";

# Modules.
use PYX::Write::Tags;
#use Test::More 'tests' => 2;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Comment writing.\n";
# TODO Cannot implement.
# ok(go($class, "$test_main_dir/data/comment1.pyx"), '<!--comment-->');
# ok(go($class, "$test_main_dir/data/comment2.pyx"), "<!--comment\ncomment-->");
