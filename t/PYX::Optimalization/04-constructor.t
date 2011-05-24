# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use PYX::Optimalization;
use Test::More 'tests' => 2;

eval {
	PYX::Optimalization->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

eval {
	PYX::Optimalization->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");
