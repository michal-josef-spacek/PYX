# $Id: 01_version.t,v 1.5 2006-08-30 16:57:30 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.03');
