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
	is($self->{'line'}, "A$att $attval");
}

# Process start tag.
sub start_tag {
	my ($self, $tag) = @_;
	is($self->{'line'}, "($tag");
}

# Process end tag.
sub end_tag {
	my ($self, $tag) = @_;
	is($self->{'line'}, ")$tag");
}

# Process data.
sub data {
	my ($self, $data) = @_;
	is($self->{'line'}, "-$data");
}

# Process instruction.
sub instruction {
	my ($self, $target, $code) = @_;
	is($self->{'line'}, "?$target $code");
}

# Process comment.
sub comment {
	my ($self, $comment) = @_;
	is($self->{'line'}, "_$comment");
}

# Process other.
sub other {
	my ($self, $other) = @_;
	is($self->{'line'}, $other);
}
