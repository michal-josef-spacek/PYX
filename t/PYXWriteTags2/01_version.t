# $Id: 01_version.t,v 1.1 2005-07-16 23:42:36 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.1');
