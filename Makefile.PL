# $Id: Makefile.PL,v 1.5 2005-06-22 17:49:21 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'PYX',
	'VERSION_FROM' => 'PYX.pm',
	'AUTHOR' => 'Michal Spacek',

	# Scripts.
	'EXE_FILES' => [
		'bin/pyx2',
		'bin/pyx2xml_tags',
		'bin/pyx2xml_raw',
	],
);
