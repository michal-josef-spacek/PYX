# $Id: Makefile.PL,v 1.21 2006-03-23 22:17:16 skim Exp $

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
		'bin/pyx_optimalization',
		'bin/pyx_xml_normalization',
	],
	'NAME' => 'PYX',
	'PREREQ_PM' => {
		'PYX::Utils' => 0.01,
		'Error::Simple::Multiple' => 0.02,
	},
	'VERSION' => '0.02',
);
