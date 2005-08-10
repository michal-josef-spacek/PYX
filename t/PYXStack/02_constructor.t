# $Id: 02_constructor.t,v 1.1 2005-08-10 14:25:24 skim Exp $

# Modules.
use IO::Scalar;

print "Testing: new('') bad constructor.\n" if $debug;
my $obj;
eval {
	$obj = $class->new('');
};
$@ =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Unknown parameter ''.");

print "Testing: new('something' => 'value') bad constructor.\n" if $debug;
eval {
	$obj = $class->new('something' => 'value');
};
$@ =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Unknown parameter 'something'.");

print "Testing: new() bad constructor - without handlers.\n" if $debug;
eval {
	$obj = $class->new;
};
$@ =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Cannot exist input file handler ''.");

