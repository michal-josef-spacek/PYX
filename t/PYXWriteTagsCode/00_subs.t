# $Id: 00_subs.t,v 1.2 2005-08-14 18:29:42 skim Exp $

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
		$obj->parse;
	};
	if ($@) {
		print STDERR $@;
	}

	# Return Tags struct.
	return $obj->get_tags_code;
}

