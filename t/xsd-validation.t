#!/usr/bin/env perl

use Test::Most;
use XML::LibXML;
use Path::Tiny qw(path);

my $tests_dir = path(__FILE__)->parent(1);
my $xml_str   = do { local $/; <DATA> };

subtest 'Valid XML' => sub {
    ok $xml_str,
        'Given an XML string';

    ok my $xml_doc = XML::LibXML->load_xml(string => $xml_str),
        '... it is successfully loaded by XML::LibXML';

    ok my $xsd_doc = XML::LibXML::Schema->new( location => $tests_dir . '/xml/schemas/book.xsd'),
        '... and its XSD is successfuly loaded also';

    lives_ok sub { $xsd_doc->validate($xml_doc) },
        '... and validation does not throw an error since the XML is valid';
};

subtest 'Invalid XML' => sub {
    $xml_str =~ s[200][-200]; note 'changed numPages value to -200';

    ok $xml_str,
        'Given an XML string';

    ok my $xml_doc = XML::LibXML->load_xml(string => $xml_str),
        '... it is successfully loaded by XML::LibXML';

    ok my $xsd_doc = XML::LibXML::Schema->new(location => $tests_dir . '/xml/schemas/book.xsd'),
        '... and the XSD is successfuly loaded also';

    throws_ok sub { $xsd_doc->validate($xml_doc) }, qr/validity?.+error/,
        '... and validation throws an error since the XML is invalid';
};

done_testing();

__DATA__
<?xml version="1.0" encoding="utf-8" ?>
<book>
    <title>XML Validation</title>
    <author>John Example</author>
    <numPages>200</numPages>
</book>