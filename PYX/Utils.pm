#------------------------------------------------------------------------------
package PYX::Utils;
#------------------------------------------------------------------------------
# $Id: Utils.pm,v 1.7 2005-07-13 13:24:54 skim Exp $

# Pragmas.
use strict;

# Modules.
use Exporter;

# Version.
our $VERSION = 0.1;

# Global variables.
use vars qw(%entities $entities @ISA @EXPORT_OK);

# Inheritance.
@ISA = ('Exporter');

# Export.
@EXPORT_OK = ('decode', 'encode', 'entity_encode');

# Encoding table.
%entities = (
        '<' => '&lt;',
        '&' => '&amp;',
        '"' => '&quot;',
);
$entities = join('', keys(%entities));

#------------------------------------------------------------------------------
sub decode {
#------------------------------------------------------------------------------
# Decode chars.

	my $text = shift;
	$text =~ s/\n/\\n/g;
	return $text;
}

#------------------------------------------------------------------------------
sub encode {
#------------------------------------------------------------------------------
# Encode chars.

	my $text = shift;
	$text =~ s/\\n/\n/g;
	return $text;
}

#------------------------------------------------------------------------------
sub entity_encode {
#------------------------------------------------------------------------------
# Encode some chars for html.

	my $text = shift;
	$text =~ s/([$entities])/$entities{$1}/g;	
	return $text;
}

1;
