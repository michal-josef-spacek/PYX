# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::XMLNorm;
use Test::More 'tests' => 4;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: parse() method.\n";
my $rules = {
	'tr' => ['td', 'tr'],
	'td' => ['td'],
	'table' => ['td', 'tr'],
	'html' => ['body'],
	'*' => ['br', 'hr', 'link', 'meta', 'input']
};
my $obj = PYX::XMLNorm->new(
	'rules' => $rules,
);
my $ret = get_stdout($obj, "$test_main_dir/data/example9.pyx");
my $right_ret = <<"END";
(html
(head
(link
)link
(meta
)meta
)head
(body
(input
)input
(br
)br
(hr
)hr
)body
)html
END
is($ret, $right_ret);

$ret = get_stdout($obj, "$test_main_dir/data/example10.pyx");
$right_ret = <<"END";
(table
(tr
(td
-example1
)td
(td
-example2
)td
)tr
(tr
(td
-example1
)td
(td
-example2
)td
)tr
)table
END
is($ret, $right_ret);

$ret = get_stdout($obj, "$test_main_dir/data/example11.pyx");
is($ret, $right_ret);

$ret = get_stdout($obj, "$test_main_dir/data/example12.pyx");
$right_ret = <<"END";
(html
(head
(LINK
)LINK
(meta
)meta
(META
)META
)head
(body
(input
)input
(br
)br
(BR
)BR
(hr
)hr
(hr
)hr
)body
)html
END
is($ret, $right_ret);
