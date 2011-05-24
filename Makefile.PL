# Pragmas.
use strict;
use warnings;

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Špaček <skim@cpan.org>',
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
		'bin/pyx2graphviz',
	],
	'NAME' => 'PYX',
	'PREREQ_PM' => {
		'Class::Utils' => 0.01,
		'Error::Simple::Multiple' => 0.05,
		'Exporter' => 0,
		'File::Object' => 0,
		'GraphViz' => 0,
		'PYX::Utils' => 0.01,
		'Readonly' => 0,
	},
	'VERSION' => '0.04',
	'test' => {
		'TESTS' => 't/PYX/*.t '.
			't/PYX::Checker/*.t '.
			't/PYX::Filter/*.t '.
			't/PYX::Get/*.t '.
			't/PYX::GraphViz/*.t '.
			't/PYX::Optimalization/*.t '.
			't/PYX::Parser/*.t '.
			't/PYX::Sort/*.t '.
			't/PYX::Stack/*.t '.
			't/PYX::Write::Raw/*.t '.
			't/PYX::Write::Tags/*.t '.
			't/PYX::Write::Tags2/*.t '.
			't/PYX::Write::Tags2::Code/*.t '.
			't/PYX::Write::Tags::Code/*.t '.
			't/PYX::XMLNorm/*.t',
	},
);
