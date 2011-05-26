# Pragmas.
use strict;
use warnings;

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Špaček <skim@cpan.org>',
	'EXE_FILES' => [
		'bin/pyx_html_simple',
		'bin/pyx_attr_sort',
		'bin/pyx_stack',
	],
	'NAME' => 'PYX',
	'PREREQ_PM' => {
		'Class::Utils' => 0.01,
		'Error::Pure' => 0.01,
		'Exporter' => 0,
		'File::Object' => 0,
		'PYX::Utils' => 0.01,
		'Readonly' => 0,
	},
	'VERSION' => '0.04',
	'test' => {
		'TESTS' => 't/PYX/*.t '.
			't/PYX::Parser/*.t '.
			't/PYX::Sort/*.t '.
			't/PYX::Stack/*.t',
	},
);
