# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper function.

	my ($class, $file) = @_;

	# PYX::Parser object.
	my $stderr;
	tie *STDERR, 'IO::Scalar', \$stderr;
	my $obj = $class->new(
		'output_rewrite' => 1,
	);
	untie *STDERR;
	$stderr =~ s/(.*)\ at.*\n/$1/ if $stderr;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	eval {
		$obj->parse_file($file);
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	return $stdout;
}
