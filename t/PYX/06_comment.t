
print "Testing: comment() function.\n" if $debug;
my $comment = 'comment';
my $ret = eval $class.'::comment($comment)';
ok($ret, '_comment');

$comment = "comment\ncomment";
$ret = eval $class.'::comment($comment)';
ok($ret, '_comment\ncomment');
