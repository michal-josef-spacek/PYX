#!/usr/bin/perl
# $Id: 08_pyx_write_tags2.t,v 1.1 2005-07-16 23:43:13 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Write::Tags2;
use Test;

# Global variables.
use vars qw/$debug $obj $class $dir/;

BEGIN {
	# Name of class.
	$dir = $class = 'PYX::Write::Tags2';
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

