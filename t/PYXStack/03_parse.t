# $Id: 03_parse.t,v 1.3 2005-11-14 17:00:49 skim Exp $

# Modules.
use IO::Scalar;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXStack";

print "Testing: parse() method.\n" if $debug;

# Open file.
my $input_handler;
open($input_handler, "<$test_dir/data/example1.pyx");

# PYX::Parser object.
my $obj = $class->new(
	'input_file_handler' => $input_handler,
	'verbose' => 1,
);

# Parse.
my $stdout;
tie *STDOUT, 'IO::Scalar', \$stdout;
eval {
$obj->parse_handler;
};
print "$@\n";
untie *STDOUT;

# Close file.
close($input_handler);

# Right output.
my $right_out = <<"END";
xml
xml/xml2
xml/xml2/xml3
xml/xml2
xml
END

# Check.
ok($stdout, $right_out);
