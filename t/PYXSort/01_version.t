# $Id: 01_version.t,v 1.1 2005-08-10 14:55:01 skim Exp $

print "Testing: Version.\n" if $debug;
ok(eval('$'.$class.'::VERSION'), '0.01');
