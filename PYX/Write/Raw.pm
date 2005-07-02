#------------------------------------------------------------------------------
package PYX::Write::Raw;
#------------------------------------------------------------------------------
# $Id: Raw.pm,v 1.3 2005-07-02 10:41:50 skim Exp $

# Version.
our $VERSION = 0.1;

# Modules.
use Carp;
use PYX::Parser;
use PYX::Utils;

# Global variables.
use vars qw(@tag $tag_open);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = {};
	bless $self, $class;

	# Input file handler.
	$self->{'input_file_handler'} = '';

	# Process params.
	croak "$class: Created with odd number of parameters - should be ".
		"of the form option => value." if (@_ % 2);
	for (my $x = 0; $x <= $#_; $x += 2) {
		if (exists $self->{$_[$x]}) {
			$self->{$_[$x]} = $_[$x+1];
		} else {
			croak "$class: Bad parameter '$_[$x]'.";
		}
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'input_file_handler' => $self->{'input_file_handler'},
		'start_tag' => \&_start_tag,
		'end_tag' => \&_end_tag,
		'data' => \&_data,
		'special_tag' => \&_special_tag,
		'attribute' => \&_attribute,
		'comment' => \&_comment,
	);

	# Tag values.
	@tag = ();

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Start of parsing.

	my $self = shift;
	$self->{'pyx_parser'}->parse();
}

#------------------------------------------------------------------------------
# Private functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process start of tag.

	shift;
	my $tag = shift;
	_end_of_start_tag();
	print "<$tag";
	$tag_open = 1;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process end of tag.

	shift;
	my $tag = shift;
	_end_of_start_tag();
	print "</$tag>";
}

#------------------------------------------------------------------------------
sub _data {
#------------------------------------------------------------------------------
# Process data.

	shift;
	my $data = PYX::Utils::decode(shift);
	_end_of_start_tag();
	print PYX::Utils::entity_encode($data);	
}

#------------------------------------------------------------------------------
sub _attribute {
#------------------------------------------------------------------------------
# Process attribute.

	shift;
	while (@_) {
		my ($att, $attval) = (shift @_, shift @_);
		print " $att=\"", PYX::Utils::entity_encode($attval), '"';
	}
}

#------------------------------------------------------------------------------
sub _special_tag {
#------------------------------------------------------------------------------
# Process special tag.

	shift;
	my $tag = shift;
	_end_of_start_tag();
	print "<?", PYX::Utils::entity_encode($value), "?>";
}

#------------------------------------------------------------------------------
sub _end_of_start_tag {
#------------------------------------------------------------------------------
# Ends start tag.

	if ($tag_open) {
		print '>';
		$tag_open = 0;
	}
}

#------------------------------------------------------------------------------
sub _comment {
#------------------------------------------------------------------------------
# Process comment.

	shift;
	my $comment = PYX::Utils::decode(shift);
	print $comment;
	
}

1;
