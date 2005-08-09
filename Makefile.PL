# $Id: Makefile.PL,v 1.14 2005-08-09 07:27:43 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'PYX',
	'VERSION_FROM' => 'PYX/Parser.pm',
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
	],
	'PREREQ_PM' => {
		'PYX::Utils' => 0.01,
	}
);
