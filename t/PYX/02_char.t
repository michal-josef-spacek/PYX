# $Id: 02_char.t,v 1.1 2005-06-26 16:36:08 skim Exp $

print "Testing: char() function.\n" if $debug;
my $char = 'char';
my $ret = eval $class.'::char($char)';
ok($ret, '-char');

$char = "char\nchar";
$ret = eval $class.'::char($char)';
ok($ret, '-char\nchar');

