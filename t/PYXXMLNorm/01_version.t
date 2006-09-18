# $Id: 01_version.t,v 1.2 2006-09-18 09:29:16 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.02');
