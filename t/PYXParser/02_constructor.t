# $Id: 02_constructor.t,v 1.5 2005-08-26 19:43:30 skim Exp $

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
my $stderr;
tie *STDERR, 'IO::Scalar', \$stderr;
eval {
	$obj = $class->new;
};
untie *STDERR;
$stderr =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Cannot exist input file handler ''.\n");
ok($stderr, "$class: Cannot defined handlers.");

