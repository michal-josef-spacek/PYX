# $Id: 06_comment.t,v 1.4 2005-08-13 20:37:54 skim Exp $

print "Testing: comment() function.\n" if $debug;
my $comment = 'comment';
my $ret = eval $class.'::comment($comment)';
ok($ret, '_comment');

$comment = "comment\ncomment";
$ret = eval $class.'::comment($comment)';
ok($ret, '_comment\ncomment');
