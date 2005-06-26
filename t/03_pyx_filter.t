#!/usr/bin/perl
# $Id: 03_pyx_filter.t,v 1.3 2005-06-26 10:10:27 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Filter;
use Test;

# Global variables.
use vars qw/$debug $obj $class $dir/;

BEGIN {
	# Name of class.
	$dir = $class = 'PYX::Filter';
	$dir =~ s/:://g;

        my $tests = `grep -r \"^ok(\" t/$dir/*.t | wc -l`;
        chomp $tests;
        plan('tests' => $tests);

        # Debug.
        $debug = 1;
}

# Prints debug information about class.
print "\nClass '$class'\n" if $debug;

# For every test for this Class.
my @list = `ls t/$dir/*.t`;
foreach (@list) {
        chomp;
        do $_;
	print $@;
}

