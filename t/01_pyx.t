#!/usr/bin/perl
# $Id: 01_pyx.t,v 1.1 2005-06-17 19:59:23 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX;
use Test;

# Global variables.
use vars qw/$debug $obj $class/;

BEGIN {
        my $tests = `grep -r \"^ok(\" t/Pyx/*.t | wc -l`;
        chomp $tests;
        plan('tests' => $tests);

        # Debug.
        $debug = 1;
}

# Name of class.
$class = 'PYX';

# Prints debug information about class.
print "\nClass '$class'\n" if $debug;

# For every test for this Class.
my @list = `ls t/Pyx/*.t`;
foreach (@list) {
        chomp;
        do $_;
	print $@;
}

