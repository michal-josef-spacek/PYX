# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::XMLNorm;
use Test::More 'tests' => 4;

# Include helpers.
do $test_main_dir.'/get_stdout4.inc';

print "Testing: parse() method.\n";
my $rules = {
	'tr' => ['td', 'tr'],
	'td' => ['td'],
	'table' => ['td', 'tr'],
	'html' => ['body'],
	'*' => ['br', 'hr', 'link', 'meta', 'input']
};
my $ret = get_stdout4('PYX::XMLNorm', "$test_main_dir/data/example9.pyx", $rules);
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

$ret = get_stdout4('PYX::XMLNorm', "$test_main_dir/data/example10.pyx", $rules);
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

$ret = get_stdout4('PYX::XMLNorm', "$test_main_dir/data/example11.pyx", $rules);
is($ret, $right_ret);

$ret = get_stdout4('PYX::XMLNorm', "$test_main_dir/data/example12.pyx", $rules);
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
