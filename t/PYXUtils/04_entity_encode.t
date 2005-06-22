# $Id: 04_entity_encode.t,v 1.1 2005-06-22 17:15:30 skim Exp $

print "Testing: entity_encode function.\n" if $debug;
my $str = 'a<b';
my $out_str = eval $class.'::entity_encode($str)';
ok($out_str, "a&lt;b");

$str = 'a&b';
$out_str = eval $class.'::entity_encode($str)';
ok($out_str, "a&amp;b");

$str = 'a"b';
$out_str = eval $class.'::entity_encode($str)';
ok($out_str, "a&quot;b");

$str = '<&"';
$out_str = eval $class.'::entity_encode($str)';
ok($out_str, "&lt;&amp;&quot;");
