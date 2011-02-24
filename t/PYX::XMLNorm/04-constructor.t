# Modules.
use English qw(-no_match_vars);
use PYX::XMLNorm;
use Test::More 'tests' => 2;

print "Testing: new('') bad constructor.\n";
my $obj;
eval {
	$obj = $class->new('');
};
ok($EVAL_ERROR, "Unknown parameter ''.\n");

print "Testing: new('something' => 'value') bad constructor.\n";
eval {
	$obj = $class->new(
		'something' => 'value',
	);
};
ok($EVAL_ERROR, "Unknown parameter 'something'.\n");
