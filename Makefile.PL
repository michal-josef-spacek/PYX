# $Id: Makefile.PL,v 1.2 2005-06-17 20:00:27 skim Exp $

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
	],
);
