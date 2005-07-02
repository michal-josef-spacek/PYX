# $Id: 02_char.t,v 1.1 2005-07-02 13:29:10 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Char writing.\n" if $debug;
ok(go($class, "$test_dir/data/char1.pyx"), "char\n");
ok(go($class, "$test_dir/data/char2.pyx"), "char char\n");
