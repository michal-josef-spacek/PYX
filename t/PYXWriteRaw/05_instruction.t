# $Id: 05_instruction.t,v 1.4 2005-07-02 13:29:09 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

print "Testing: Instruction writing.\n" if $debug;
ok(go($class, "$test_dir/data/instruction1.pyx"), '<?target data?>');
ok(go($class, "$test_dir/data/instruction2.pyx"), "<?target data\ndata?>");
