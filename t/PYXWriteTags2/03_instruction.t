# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteTags2";

print "Testing: Instruction writing.\n" if $debug;
#ok(go($class, "$test_dir/data/instruction1.pyx"), '<?target data?>');
#ok(go($class, "$test_dir/data/instruction2.pyx"), "<?target data\ndata?>");

ok(go2($class, "$test_dir/data/instruction1.pyx"), '<?target data?>');
ok(go2($class, "$test_dir/data/instruction2.pyx"), "<?target data\\ndata?>");

#ok(go3($class, "$test_dir/data/instruction1.pyx"), '<?target data?>');
#ok(go3($class, "$test_dir/data/instruction2.pyx"), "<?target data\ndata?>");
