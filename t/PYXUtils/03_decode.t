# $Id: 03_decode.t,v 1.1 2005-06-22 13:30:34 skim Exp $

print "Testing: decode function.\n" if $debug;
my $str = "a\\nb";
my $out_str = eval $class.'::decode($str)';
ok($out_str, "a\nb");
