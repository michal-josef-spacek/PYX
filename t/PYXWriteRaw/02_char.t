# $Id: 02_char.t,v 1.3 2005-07-02 13:03:27 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: Char writing.\n" if $debug;
ok(go($class, "$test_dir/data/char1.pyx"), 'char');
ok(go($class, "$test_dir/data/char2.pyx"), "char\nchar");
