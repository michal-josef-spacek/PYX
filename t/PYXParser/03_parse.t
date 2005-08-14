# $Id: 03_parse.t,v 1.4 2005-08-14 18:29:34 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXParser";

print "Testing: parse() method.\n" if $debug;

# Open file.
my $input_handler;
open($input_handler, "<$test_dir/data/parse.pyx");

# PYX::Parser object.
my $obj = $class->new(
	'input_file_handler' => $input_handler,
	'attribute' => \&attribute,
	'start_tag' => \&start_tag,
	'end_tag' => \&end_tag,
	'data' => \&data,
	'instruction' => \&instruction,
	'comment' => \&comment,
	'other' => \&other,
);

# Parse.
$obj->parse;

# Close file.
close($input_handler);

#------------------------------------------------------------------------------
sub attribute {
#------------------------------------------------------------------------------
# Process attributes.

	my ($self, $att, $attval) = @_;
	ok($self->{'line'}, "A$att $attval");
}

#------------------------------------------------------------------------------
sub start_tag {
#------------------------------------------------------------------------------
# Process start tag.

	my ($self, $tag) = @_;
	ok($self->{'line'}, "($tag");
}

#------------------------------------------------------------------------------
sub end_tag {
#------------------------------------------------------------------------------
# Process end tag.

	my ($self, $tag) = @_;
	ok($self->{'line'}, ")$tag");
}

#------------------------------------------------------------------------------
sub data {
#------------------------------------------------------------------------------
# Process data.

	my ($self, $data) = @_;
	ok($self->{'line'}, "-$data");
}

#------------------------------------------------------------------------------
sub instruction {
#------------------------------------------------------------------------------
# Process instruction.

	my ($self, $target, $data) = @_;
	ok($self->{'line'}, "?$target $data");
}

#------------------------------------------------------------------------------
sub comment {
#------------------------------------------------------------------------------
# Process comment.

	my ($self, $comment) = @_;
	ok($self->{'line'}, "_$comment");
}

#------------------------------------------------------------------------------
sub other {
#------------------------------------------------------------------------------
# Process other.

	my ($self, $other) = @_;
	ok($self->{'line'}, $other);
}
