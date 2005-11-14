# $Id: 00_subs.t,v 1.4 2005-11-14 17:00:51 skim Exp $

# Modules.
use IO::Scalar;

#------------------------------------------------------------------------------
sub go {
#------------------------------------------------------------------------------
# Helper function.

	my $class = shift;
	my $file = shift;
	my $input_handler;
	open($input_handler, "<$file");
	my $obj = $class->new(
		'input_file_handler' => $input_handler,
	);
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
