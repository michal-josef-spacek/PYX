# Modules.
use English qw(-no_match_vars);
use PYX::Optimalization;
use Test::More 'tests' => 2;

print "Testing: new('') bad constructor.\n";
eval {
	PYX::Optimalization->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

print "Testing: new('something' => 'value') bad constructor.\n";
eval {
	PYX::Optimalization.->new('something' => 'value');
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");
