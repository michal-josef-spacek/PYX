# $Id: 01_version.t,v 1.3 2006-04-10 01:08:22 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.02');
