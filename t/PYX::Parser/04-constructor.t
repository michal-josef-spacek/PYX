# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use PYX::Parser;
use Test::More 'tests' => 2;

eval {
	PYX::Parser->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

eval {
	PYX::Parser->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");
