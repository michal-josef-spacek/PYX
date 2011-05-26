# Modules.
use PYX qw(end_tag);
use Test::More 'tests' => 1;

my $tag = 'tag';
my $ret = end_tag($tag);
is($ret, ')tag');
