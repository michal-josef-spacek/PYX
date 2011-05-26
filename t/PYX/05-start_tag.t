# Pragmas.
use strict;
use warnings;

# Modules.
use PYX qw(start_tag);
use Test::More 'tests' => 5;

my $tag = 'tag';
my @attr = ();
my ($ret) = start_tag($tag, @attr);
is($ret, '(tag');

@attr = ('par', 'val');
($ret, my $ret2) = start_tag($tag, @attr);
is($ret, '(tag');
is($ret2, 'Apar val');

@attr = ('par', "val\nval");
($ret, $ret2) = start_tag($tag, @attr);
is($ret, '(tag');
is($ret2, 'Apar val\nval');
