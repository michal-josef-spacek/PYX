# $Id: 03_parse.t,v 1.5 2006-02-17 13:49:33 skim Exp $

# Modules.
use IO::Scalar;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXStack";

print "Testing: parse_file() method.\n" if $debug;

# PYX::Parser object.
my $obj = $class->new(
	'verbose' => 1,
);

# Parse.
my $stdout;
tie *STDOUT, 'IO::Scalar', \$stdout;
$obj->parse_file($test_dir.'/data/example1.pyx');
untie *STDOUT;

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
