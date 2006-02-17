# $Id: 00_subs.t,v 1.4 2006-02-17 13:49:42 skim Exp $

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper.

	my ($class, $file) = @_;

	# PYX::Write::Tags::Code object.
	my $obj = $class->new;

	# Parse.
	eval {
		$obj->parse_file($file);
	};
	if ($@) {
		print STDERR $@;
	}

	# Return Tags struct.
	return $obj->get_tags_code;
}

