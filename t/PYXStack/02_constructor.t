# $Id: 02_constructor.t,v 1.3 2005-11-14 17:00:49 skim Exp $

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

