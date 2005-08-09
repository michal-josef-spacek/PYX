# $Id: Makefile.PL,v 1.17 2005-08-09 10:55:34 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Spacek',
	'EXE_FILES' => [
		'bin/pyx2xml_tags',
		'bin/pyx2xml_tags_without_indent',
		'bin/pyx2xml_tags2',
		'bin/pyx2xml_raw',
		'bin/pyx_html_simple',
		'bin/pyx_attr_sort',
		'bin/pyx2tags_code',
		'bin/pyx2tags2_code',
		'bin/pyx_stack',
	],
	'NAME' => 'PYX',
	'PREREQ_PM' => {
		'PYX::Utils' => 0.01,
	},
	'VERSION_FROM' => 'PYX/Parser.pm',
);
