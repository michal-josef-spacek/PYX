# $Id: 01_version.t,v 1.1 2005-06-17 19:59:32 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.1');
