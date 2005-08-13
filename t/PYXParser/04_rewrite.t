# $Id: 04_rewrite.t,v 1.3 2005-08-13 14:19:08 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXParser";

print "Testing: parse() method with output_rewrite.\n" if $debug;
ok(go($class, "$test_dir/data/char1.pyx"), <<'END');
-char
END

ok(go($class, "$test_dir/data/char2.pyx"), <<'END');
-char\nchar
END

ok(go($class, "$test_dir/data/start_tag1.pyx"), <<'END');
(tag
END

ok(go($class, "$test_dir/data/start_tag2.pyx"), <<'END');
(tag
Apar val
END

ok(go($class, "$test_dir/data/start_tag3.pyx"), <<'END');
(tag
Apar val\nval
END

ok(go($class, "$test_dir/data/end_tag1.pyx"), <<'END');
)tag
END

ok(go($class, "$test_dir/data/instruction1.pyx"), <<'END');
?target data
END

ok(go($class, "$test_dir/data/instruction2.pyx"), <<'END');
?target data\ndata
END

ok(go($class, "$test_dir/data/comment1.pyx"), <<'END');
_comment
END

ok(go($class, "$test_dir/data/comment2.pyx"), <<'END');
_comment\ncomment
END

ok(go($class, "$test_dir/data/example1.pyx"), <<'END');
(xml
-text
)xml
END

