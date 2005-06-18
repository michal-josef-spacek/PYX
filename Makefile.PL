# $Id: Makefile.PL,v 1.3 2005-06-18 09:37:47 skim Exp $

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
	],
);
