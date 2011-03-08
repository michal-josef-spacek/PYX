# Modules.
use File::Object;
use PYX::XMLNorm;
use Test::More 'tests' => 7;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: parse() method.\n";
my $rules = {
	'*' => ['br', 'hr', 'link', 'meta', 'input'],
	'html' => ['body'],
	'table' => ['tr'],
	'td' => ['td'],
	'th' => ['th'],
	'tr' => ['td', 'th', 'tr'],
};
my $obj = PYX::XMLNorm->new(
	'rules' => $rules,
);
my $ret = get_stdout($obj, "$data_dir/example9.pyx");
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

SKIP: {
skip "Bug", 1;
$ret = get_stdout($obj, "$data_dir/example10.pyx");
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
}

SKIP: {
skip "Bug.", 1;
$ret = get_stdout($obj, "$data_dir/example11.pyx");
is($ret, $right_ret);
}

$ret = get_stdout($obj, "$data_dir/example12.pyx");
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

SKIP: {
skip "Bug.", 1;

$ret = get_stdout($obj, "$data_dir/example13.pyx");
$right_ret = <<"END";
(td
(table
(tr
(td
-text1
)td
(td
-text2
)td
)tr
)table
)td
END
is($ret, $right_ret);
}

# Test.
$ret = get_stdout($obj, "$data_dir/example14.pyx");
$right_ret = <<"END";
(br
)br
-text
END
is($ret, $right_ret);

# Test.
$ret = get_stdout($obj, "$data_dir/example15.pyx");
$right_ret = <<"END";
(br
)br
(br
)br
-text
END
is($ret, $right_ret);
