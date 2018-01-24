#!/usr/bin/env perl

use v5.18;
use strict;

use XML::LibXML;
use Try::Tiny qw(try catch);

my $xml_doc = XML::LibXML->load_xml(location => './xml/book.xml');
my $xsd_doc = XML::LibXML::Schema->new(location => './xml/schemas/book.xsd');

my $is_xml_valid = try {
    not $xsd_doc->validate($xml_doc);
}
catch {
    say '==> ' . $_;
    return 0;
};
say $is_xml_valid ? 'Valid' : 'Invalid';