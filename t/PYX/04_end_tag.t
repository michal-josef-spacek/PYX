
print "Testing: end_tag() function.\n" if $debug;
my $tag = 'tag';
my $ret = eval $class.'::end_tag($tag)';
ok($ret, ')tag');

