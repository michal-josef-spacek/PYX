# $Id: 02_encode.t,v 1.2 2005-07-02 13:17:16 skim Exp $

print "Testing: encode function.\n" if $debug;
my $str = 'a\nb';
my $out_str = eval $class.'::encode($str)';
ok($out_str, "a\nb");
