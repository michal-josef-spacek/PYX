# $Id: 00_subs.t,v 1.1 2005-07-02 13:03:27 skim Exp $

# Modules.
use IO::Scalar;

# Function.
sub go {
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
		$obj->parse();
	};
	if ($@) {
		print STDERR $@;
	}
	untie *STDOUT;
	close($input_handler);
	return $stdout;
}
