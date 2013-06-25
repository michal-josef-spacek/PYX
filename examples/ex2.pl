#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use PYX::Parser;

# Open file.
my $file_handler = \*STDIN;
my $file = $ARGV[0];
if ($file) {
       if (! open(INF, '<', $file)) {
               die "Cannot open file '$file'.";
       }
       $file_handler = \*INF;
}

# PYX::Parser object.
my $parser = PYX::Parser->new(
       'start_tag' => \&start_tag,
       'end_tag' => \&end_tag,
);
$parser->parse_handler($file_handler);

# Close file.
if ($file) {
       close(INF);
}

# Start tag handler.
sub start_tag {
       my ($self, $tag) = @_;
       print "Start of tag '$tag'.\n";
}

# End tag handler.
sub end_tag {
       my ($self, $tag) = @_;
       print "End of tag '$tag'.\n";
}