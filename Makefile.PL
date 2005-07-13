# $Id: Makefile.PL,v 1.8 2005-07-13 13:35:29 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'PYX',
	'VERSION_FROM' => 'PYX.pm',
	'AUTHOR' => 'Michal Spacek',

	# Scripts.
	'EXE_FILES' => [
		# TODO Remove.
		'bin/pyx2',

		'bin/pyx2xml_tags',
		'bin/pyx2xml_tags_without_indent',
		'bin/pyx2xml_raw',
		'bin/pyx_html_simple',
		'bin/pyx2xml_tags_code',
	],
);
