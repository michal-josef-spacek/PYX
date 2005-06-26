# $Id: 04_end_tag.t,v 1.1 2005-06-26 16:36:08 skim Exp $

print "Testing: end_tag() function.\n" if $debug;
my $tag = 'tag';
my $ret = eval $class.'::end_tag($tag)';
ok($ret, ')tag');

