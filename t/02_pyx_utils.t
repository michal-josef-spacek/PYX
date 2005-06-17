#!/usr/bin/perl
# $Id: 02_pyx_utils.t,v 1.1 2005-06-17 19:59:23 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Utils;
use Test;

# Global variables.
use vars qw/$debug $obj $class/;

BEGIN {
        my $tests = `grep -r \"^ok(\" t/PyxUtils/*.t | wc -l`;
        chomp $tests;
        plan('tests' => $tests);

        # Debug.
        $debug = 1;
}

# Name of class.
$class = 'PYX::Utils';

# Prints debug information about class.
print "\nClass '$class'\n" if $debug;

# For every test for this Class.
my @list = `ls t/PyxUtils/*.t`;
foreach (@list) {
        chomp;
        do $_;
	print $@;
}

