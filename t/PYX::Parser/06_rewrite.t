# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t/";

# Modules.
use PYX::Parser;
use Test::More 'tests' => 11;

# Include helpers.
do $test_main_dir.'/get_stdin2.inc';

print "Testing: parse() method with output_rewrite.\n";
is(get_stdin2('PYX::Parser', "$test_main_dir/data/char1.pyx"), <<'END');
-char
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/char2.pyx"), <<'END');
-char\nchar
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/start_tag1.pyx"), <<'END');
(tag
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/start_tag2.pyx"), <<'END');
(tag
Apar val
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/start_tag3.pyx"), <<'END');
(tag
Apar val\nval
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/end_tag1.pyx"), <<'END');
)tag
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/instruction1.pyx"), <<'END');
?target data
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/instruction2.pyx"), <<'END');
?target data\ndata
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/comment1.pyx"), <<'END');
_comment
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/comment2.pyx"), <<'END');
_comment\ncomment
END

is(get_stdin2('PYX::Parser', "$test_main_dir/data/example5.pyx"), <<'END');
(xml
-text
)xml
END
