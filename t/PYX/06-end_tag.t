# Pragmas.
use strict;
use warnings;

# Modules.
use PYX qw(end_tag);
use Test::More 'tests' => 1;

# Test.
my $tag = 'tag';
my $ret = end_tag($tag);
is($ret, ')tag');
