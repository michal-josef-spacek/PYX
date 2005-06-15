# $Id: Makefile.PL,v 1.1 2005-06-15 18:50:22 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'PYX',
	'VERSION_FROM' => 'PYX.pm',
	'AUTHOR' => 'Michal Spacek',

	# Scripts.
	'EXE_FILES' => [
		'bin/pyx',
	],
);
