# $Id: 02_char.t,v 1.2 2005-07-02 12:50:51 skim Exp $

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
		print STDERR $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}

print "Testing: Char writing.\n" if $debug;
ok(go($class, "$test_dir/data/char1.pyx"), 'char');
ok(go($class, "$test_dir/data/char2.pyx"), "char\nchar");
