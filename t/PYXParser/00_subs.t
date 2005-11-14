# $Id: 00_subs.t,v 1.4 2005-11-14 17:00:46 skim Exp $

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

	# PYX::Parser object.
	my $stderr;
	tie *STDERR, 'IO::Scalar', \$stderr;
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
		'output_rewrite' => 1,
	);
	untie *STDERR;
	$stderr =~ s/(.*)\ at.*\n/$1/ if $stderr;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_handler;
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}

