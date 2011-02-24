# Modules.
use PYX qw(comment);
use Test::More 'tests' => 2;

print "Testing: comment() function.\n";
my $comment = 'comment';
my $ret = comment($comment);
is($ret, '_comment');

$comment = "comment\ncomment";
$ret = comment($comment);
is($ret, '_comment\ncomment');
