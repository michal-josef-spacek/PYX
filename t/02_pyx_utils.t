#!/usr/bin/perl
# $Id: 02_pyx_utils.t,v 1.2 2005-06-26 09:59:00 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Utils;
use Test;

# Global variables.
use vars qw/$debug $obj $class $dir/;

BEGIN {
	# Name of class.
	$class = 'PYX::Utils';
	$dir = 'PyxUtils';

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

