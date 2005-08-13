# $Id: 04_end_tag.t,v 1.3 2005-08-13 20:37:54 skim Exp $

print "Testing: end_tag() function.\n" if $debug;
my $tag = 'tag';
my $ret = eval $class.'::end_tag($tag)';
ok($ret, ')tag');

