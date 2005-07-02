# $Id: 04_end_tag.t,v 1.3 2005-07-02 13:03:27 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: End tag writing.\n" if $debug;
ok(go($class, "$test_dir/data/end_tag1.pyx"), '</tag>');
