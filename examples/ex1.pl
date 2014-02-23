#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX qw(attribute char comment end_tag instruction start_tag);

# Example output.
my @data = (
        instruction('xml', 'foo'),
        start_tag('tag'),
        attribute('key', 'val'),
        comment('comment'),
        char('data'),
        end_tag('tag'),
);

# Print out.
map { print $_."\n" } @data;

# Output:
# ?xml foo
# (tag
# Akey val
# _comment
# -data
# )tag