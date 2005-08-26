# $Id: 02_constructor.t,v 1.2 2005-08-26 19:38:39 skim Exp $

# Modules.
use IO::Scalar;

print "Testing: new('') bad constructor.\n" if $debug;
my $obj;
eval {
	$obj = $class->new('');
};
ok($@, "$class: Unknown parameter ''.\n");

print "Testing: new('something' => 'value') bad constructor.\n" if $debug;
eval {
	$obj = $class->new('something' => 'value');
};
ok($@, "$class: Unknown parameter 'something'.\n");

print "Testing: new() bad constructor - without handlers.\n" if $debug;
eval {
	$obj = $class->new;
};
ok($@, "$class: Cannot exist input file handler ''.\n");

