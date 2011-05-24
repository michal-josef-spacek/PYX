# Modules.
use File::Object;
use PYX::Parser;
use Test::More 'tests' => 11;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

my $obj = PYX::Parser->new(
	'output_rewrite' => 1,
);
is(get_stdout($obj, "$data_dir/char1.pyx"), <<'END');
-char
END

is(get_stdout($obj, "$data_dir/char2.pyx"), <<'END');
-char\nchar
END

is(get_stdout($obj, "$data_dir/start_tag1.pyx"), <<'END');
(tag
END

is(get_stdout($obj, "$data_dir/start_tag2.pyx"), <<'END');
(tag
Apar val
END

is(get_stdout($obj, "$data_dir/start_tag3.pyx"), <<'END');
(tag
Apar val\nval
END

is(get_stdout($obj, "$data_dir/end_tag1.pyx"), <<'END');
)tag
END

is(get_stdout($obj, "$data_dir/instruction1.pyx"), <<'END');
?target code
END

is(get_stdout($obj, "$data_dir/instruction2.pyx"), <<'END');
?target data\ndata
END

is(get_stdout($obj, "$data_dir/comment1.pyx"), <<'END');
_comment
END

is(get_stdout($obj, "$data_dir/comment2.pyx"), <<'END');
_comment\ncomment
END

is(get_stdout($obj, "$data_dir/example5.pyx"), <<'END');
(xml
-text
)xml
END
