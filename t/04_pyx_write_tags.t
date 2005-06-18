#!/usr/bin/perl
# $Id: 04_pyx_write_tags.t,v 1.1 2005-06-18 11:31:05 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Write::Tags;
use Test;

# Global variables.
use vars qw/$debug $obj $class/;

BEGIN {
        my $tests = `grep -r \"^ok(\" t/PyxWriteTags/*.t | wc -l`;
        chomp $tests;
        plan('tests' => $tests);

        # Debug.
        $debug = 1;
}

# Name of class.
$class = 'PYX::Write::Tags';

# Prints debug information about class.
print "\nClass '$class'\n" if $debug;

# For every test for this Class.
my @list = `ls t/PyxWriteTags/*.t`;
foreach (@list) {
        chomp;
        do $_;
	print $@;
}

