# $Id: 00_subs.t,v 1.3 2005-11-14 17:00:57 skim Exp $

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper.

	my $class = shift;
	my $file = shift;

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Write::Tags::Code object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
	);

	# Parse.
	eval {
		$obj->parse_handler;
	};
	if ($@) {
		print STDERR $@;
	}

	# Return Tags struct.
	return $obj->get_tags_code;
}

