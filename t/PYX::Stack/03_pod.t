# Modules.
use English qw(-no_match_vars);
use FindBin qw($Bin);
use File::Spec;
use Test::More 'tests' => 1;

eval 'use Test::Pod 1.00';
if ($EVAL_ERROR) {
	plan 'skip_all' => 'Test::Pod 1.00 required for testing POD';
}
my @path = File::Spec->splitdir($Bin);
splice @path, -2;
push @path, 'PYX', 'Stack.pm';
pod_file_ok(File::Spec->catfile(@path));
