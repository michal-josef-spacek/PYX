# $Id: 01_version.t,v 1.4 2005-08-13 20:37:54 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.01');
