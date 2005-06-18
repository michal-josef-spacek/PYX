# $Id: Makefile.PL,v 1.4 2005-06-18 11:29:20 skim Exp $

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
		'bin/pyx_checker',
		'bin/pyx2tags',
	],
);
