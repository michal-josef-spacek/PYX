# $Id: 00_subs.t,v 1.5 2006-02-17 13:49:34 skim Exp $

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
