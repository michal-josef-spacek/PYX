# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use PYX::Optimalization;
use Test::More 'tests' => 4;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

my $obj = PYX::Optimalization->new;
my $ret = get_stdout($obj, "$data_dir/example1.pyx");
my $right_ret = <<"END";
_comment
_comment
_comment
_comment
_comment
_comment
END
is($ret, $right_ret);

$ret = get_stdout($obj, "$data_dir/example2.pyx");
$right_ret = <<"END";
-data
-data
-data
-data
-data
-data
END
is($ret, $right_ret);

$ret = get_stdout($obj, "$data_dir/example3.pyx");
$right_ret = <<"END";
_comment
(tag
Aattr value
-data
)tag
?app vskip="10px"
END
is($ret, $right_ret);

$ret = get_stdout($obj, "$data_dir/example4.pyx");
$right_ret = <<"END";
-data data
-data data
-data data
-data data
-data data
-data data
END
is($ret, $right_ret);
