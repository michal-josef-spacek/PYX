#!/usr/bin/perl
# $Id: 07_pyx_write_tags_code.t,v 1.1 2005-07-13 14:10:09 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Write::Tags::Code;
use Test;

# Global variables.
use vars qw/$debug $obj $class $dir/;

BEGIN {
	# Name of class.
	$dir = $class = 'PYX::Write::Tags::Code';
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

