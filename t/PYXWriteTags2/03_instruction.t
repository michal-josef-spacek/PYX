# $Id: 03_instruction.t,v 1.1 2005-07-16 23:42:36 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags";

print "Testing: Instruction writing.\n" if $debug;
#ok(go($class, "$test_dir/data/instruction1.pyx"), '<?target data?>');
#ok(go($class, "$test_dir/data/instruction2.pyx"), "<?target data\ndata?>");

# TODO
ok(go2($class, "$test_dir/data/instruction1.pyx"), '<? target data ?>');
ok(go2($class, "$test_dir/data/instruction2.pyx"), "<? target data\\ndata ?>");

#ok(go3($class, "$test_dir/data/instruction1.pyx"), '<?target data?>');
#ok(go3($class, "$test_dir/data/instruction2.pyx"), "<?target data\ndata?>");
