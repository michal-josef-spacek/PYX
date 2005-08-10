# $Id: 00_subs.t,v 1.1 2005-08-10 14:55:01 skim Exp $

# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper function.

	my $class = shift;
	my $file = shift;

	# Open file.
	my $input_handler;
	open($input_handler, "<$file");

	# PYX::Sort object.
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
	);

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	$obj->parse();
	untie *STDOUT;
	close($input_handler);

	# Output.
	return $stdout;
}

