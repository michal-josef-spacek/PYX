# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use PYX::Parser;
use Test::More 'tests' => 8;
use Test::NoWarnings;

# PYX::Parser object.
my $obj = PYX::Parser->new(
	'attribute' => \&attribute,
	'start_tag' => \&start_tag,
	'end_tag' => \&end_tag,
	'data' => \&data,
	'instruction' => \&instruction,
	'comment' => \&comment,
	'other' => \&other,
);

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Parse.
$obj->parse_file($data_dir->file('parse.pyx')->s);

# Process attributes.
sub attribute {
	my ($self, $att, $attval) = @_;
	is($self->{'_line'}, "A$att $attval", 'Attribute callback.');
	return;
}

# Process start tag.
sub start_tag {
	my ($self, $tag) = @_;
	is($self->{'_line'}, "($tag", 'Start of tag callback.');
	return;
}

# Process end tag.
sub end_tag {
	my ($self, $tag) = @_;
	is($self->{'_line'}, ")$tag", 'End of tag callback.');
	return;
}

# Process data.
sub data {
	my ($self, $data) = @_;
	is($self->{'_line'}, "-$data", 'Data callback.');
	return;
}

# Process instruction.
sub instruction {
	my ($self, $target, $code) = @_;
	is($self->{'_line'}, "?$target $code", 'Instruction callback.');
	return;
}

# Process comment.
sub comment {
	my ($self, $comment) = @_;
	is($self->{'_line'}, "_$comment", 'Comment callback.');
	return;
}

# Process other.
sub other {
	my ($self, $other) = @_;
	is($self->{'_line'}, $other, 'Callback for other.');
	return;
}
