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

