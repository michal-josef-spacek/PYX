#!/usr/bin/perl
# $Id: 09_pyx_write_tags2_code.t,v 1.1 2005-07-18 12:35:19 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Write::Tags2::Code;
use Test;

# Global variables.
use vars qw/$debug $obj $class $dir/;

BEGIN {
	# Name of class.
	$dir = $class = 'PYX::Write::Tags2::Code';
	$dir =~ s/:://g;

        my $tests = `egrep -r \"^[[:space:]]*ok\\(\" t/$dir/*.t | wc -l`;
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

