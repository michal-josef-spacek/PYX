# $Id: 00_subs.t,v 1.1 2005-07-03 13:53:36 skim Exp $

# Modules.
use IO::Scalar;

# Example.
sub go {
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
	$stderr =~ s/(.*)\ at.*\n/$1/;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse();
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}

