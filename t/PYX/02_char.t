# $Id: 02_char.t,v 1.3 2005-08-13 20:37:54 skim Exp $

print "Testing: char() function.\n" if $debug;
my $char = 'char';
my $ret = eval $class.'::char($char)';
ok($ret, '-char');

$char = "char\nchar";
$ret = eval $class.'::char($char)';
ok($ret, '-char\nchar');

