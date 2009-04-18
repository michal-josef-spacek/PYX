# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Stack;
use Test::More 'tests' => 1;

# Include helpers.
do $test_main_dir.'/get_stdin3.inc';

print "Testing: parse_file() method.\n";
my $obj = PYX::Stack->new(
	'verbose' => 1,
);
my $ret = get_stdin3($obj, $test_main_dir.'/data/example8.pyx');
my $right_ret = <<'END';
xml
xml/xml2
xml/xml2/xml3
xml/xml2
xml
END
is($ret, $right_ret);
