# $Id: 03_decode.t,v 1.2 2005-07-02 13:17:16 skim Exp $

print "Testing: decode function.\n" if $debug;
my $str = "a\nb";
my $out_str = eval $class.'::decode($str)';
ok($out_str, 'a\nb');
