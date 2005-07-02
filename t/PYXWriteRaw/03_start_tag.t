# $Id: 03_start_tag.t,v 1.1 2005-07-02 12:46:37 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXWriteRaw";

# Modules.
use IO::Scalar;

# Function.
sub go {
	my $class = shift;
	my $file = shift;
	my $input_handler;
	open($input_handler, "<$file");
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
	);
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse();
	};
	if ($@) {
		print $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}

print "Testing: Start tag writing.\n" if $debug;
ok(go($class, "$test_dir/data/start_tag1.pyx"), '<tag>');
ok(go($class, "$test_dir/data/start_tag2.pyx"), '<tag par="val">');
ok(go($class, "$test_dir/data/start_tag3.pyx"), "<tag par=\"val\nval\">");
#ok(go($class, "$test_dir/data/start_tag4.pyx"), '<tag');
#ok(go($class, "$test_dir/data/start_tag5.pyx"), '<tag par="val"');
#ok(go($class, "$test_dir/data/start_tag6.pyx"), "<tag par=\"val\nval\"");
