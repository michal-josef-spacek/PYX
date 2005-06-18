#!/usr/bin/perl
# $Id: 03_pyx_filter.t,v 1.1 2005-06-18 00:50:29 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Filter;
use Test;

# Global variables.
use vars qw/$debug $obj $class/;

BEGIN {
        my $tests = `grep -r \"^ok(\" t/PyxFilter/*.t | wc -l`;
        chomp $tests;
        plan('tests' => $tests);

        # Debug.
        $debug = 1;
}

# Name of class.
$class = 'PYX::Filter';

# Prints debug information about class.
print "\nClass '$class'\n" if $debug;

# For every test for this Class.
my @list = `ls t/PyxFilter/*.t`;
foreach (@list) {
        chomp;
        do $_;
	print $@;
}

