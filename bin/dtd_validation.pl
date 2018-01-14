#!/usr/bin/env perl

use strict;
use warnings;

use XML::LibXML;
use Try::Tiny qw(try catch);
use experimental qw(say);

my $xml_doc = XML::LibXML->load_xml(location => './xml/book.xml');
my $dtd_doc = XML::LibXML::Dtd->new('', './xml/schemas/book.dtd');

my $is_xml_valid = try {
    $xml_doc->validate($dtd_doc);
}
catch {
    say '==> ' . $_;
    return 0;
};
say $is_xml_valid ? 'Valid' : 'Invalid';