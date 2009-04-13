# Modules.
use PYX qw(end_tag);
use Test::More 'tests' => 1;

print "Testing: end_tag() function.\n";
my $tag = 'tag';
my $ret = end_tag($tag);
is($ret, ')tag');
