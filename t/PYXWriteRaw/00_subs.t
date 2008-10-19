
# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper function.

	my ($class, $file) = @_;
	my $obj = $class->new;
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
