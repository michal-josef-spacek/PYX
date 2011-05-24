# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use PYX::Parser;
use Test::More 'tests' => 11;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->s;

# Test.
my $obj = PYX::Parser->new(
	'output_rewrite' => 1,
);
is(get_stdout($obj, $data_dir->file('char1.pyx')->s), <<'END');
-char
END

# Test.
is(get_stdout($obj, $data_dir->file('char2.pyx')->s), <<'END');
-char\nchar
END

# Test.
is(get_stdout($obj, $data_dir->file('start_tag1.pyx')->s), <<'END');
(tag
END

# Test.
is(get_stdout($obj, $data_dir->file('start_tag2.pyx')->s), <<'END');
(tag
Apar val
END

# Test.
is(get_stdout($obj, $data_dir->file('start_tag3.pyx')->s), <<'END');
(tag
Apar val\nval
END

# Test.
is(get_stdout($obj, $data_dir->file('end_tag1.pyx')->s), <<'END');
)tag
END

# Test.
is(get_stdout($obj, $data_dir->file('instruction1.pyx')->s), <<'END');
?target code
END

# Test.
is(get_stdout($obj, $data_dir->file('instruction2.pyx')->s), <<'END');
?target data\ndata
END

# Test.
is(get_stdout($obj, $data_dir->file('comment1.pyx')->s), <<'END');
_comment
END

# Test.
is(get_stdout($obj, $data_dir->file('comment2.pyx')->s), <<'END');
_comment\ncomment
END

# Test.
is(get_stdout($obj, $data_dir->file('example5.pyx')->s), <<'END');
(xml
-text
)xml
END
