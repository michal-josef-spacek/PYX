# $Id: 02_char.t,v 1.1 2005-07-16 23:42:36 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Char writing.\n" if $debug;
#ok(go($class, "$test_dir/data/char1.pyx"), "char\n");
#ok(go($class, "$test_dir/data/char2.pyx"), "char char\n");

# TODO " " in begin of char?
ok(go2($class, "$test_dir/data/char1.pyx"), " char");
ok(go2($class, "$test_dir/data/char2.pyx"), " char\nchar");

#ok(go3($class, "$test_dir/data/char1.pyx"), "char\n");
#ok(go3($class, "$test_dir/data/char2.pyx"), "char char\n");
