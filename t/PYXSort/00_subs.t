# $Id: 00_subs.t,v 1.4 2006-02-17 13:49:32 skim Exp $

# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper function.

	my ($class, $file) = @_;

	# PYX::Sort object.
	my $obj = $class->new;

	# Parse example.
	my $stdout;
	tie *STDOUT, 'IO::Scalar', \$stdout;
	$obj->parse_file($file);
	untie *STDOUT;

	# Output.
	return $stdout;
}

