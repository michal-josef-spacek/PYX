# $Id: 02_constructor.t,v 1.1 2005-06-26 19:52:03 skim Exp $

# Tests directory.
my $test_dir = "$ENV{'PWD'}/t/Tags";

# Modules.
use IO::Scalar;

print "Testing: new('') bad constructor.\n" if $debug;
eval {
	$obj = $class->new('');
};
$@ =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Created with odd number of parameters - should be of ".
	"the form option => value.");

print "Testing: new('something' => 'value') bad constructor.\n" if $debug;
eval {
	$obj = $class->new('something' => 'value');
};
$@ =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Bad parameter 'something'.");

print "Testing: new() bad constructor - without handlers.\n" if $debug;
my $stderr;
tie *STDERR, 'IO::Scalar', \$stderr;
eval {
	$obj = $class->new();
};
untie *STDERR;
$@ =~ s/(.*)\ at.*\n/$1/;
$stderr =~ s/(.*)\ at.*\n/$1/;
ok($@, "$class: Cannot exist input file handler ''.");
ok($stderr, "$class: Cannot defined handlers.");

