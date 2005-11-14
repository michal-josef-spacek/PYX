# $Id: 02_char.t,v 1.3 2005-11-14 15:58:38 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Char writing.\n" if $debug;
ok(go($class, "$test_dir/data/char1.pyx"), "char\n");
ok(go($class, "$test_dir/data/char2.pyx"), "char char\n");

ok(go2($class, "$test_dir/data/char1.pyx"), "char\n");
ok(go2($class, "$test_dir/data/char2.pyx"), "char char\n");
