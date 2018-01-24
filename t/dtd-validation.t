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

    ok my $dtd_doc = XML::LibXML::Dtd->new('', $tests_dir . '/xml/schemas/book.dtd'),
        '... and its DTD is successfuly loaded also';

    lives_ok sub { $xml_doc->validate($dtd_doc) },
        '... and validation does not throw an error since the XML is valid';
};

subtest 'Invalid XML' => sub {

    ok $xml_str,
        'Given an XML string';

    $xml_str =~ s[<author>.+?</author>][];
    note 'removed the author element';

    ok my $xml_doc   = XML::LibXML->load_xml(string => $xml_str),
        '... it is successfully loaded by XML::LibXML';

    ok my $dtd_doc = XML::LibXML::Dtd->new('', $tests_dir . '/xml/schemas/book.dtd'),
        '... and the DTD is successfuly loaded also';

    throws_ok sub { $xml_doc->validate($dtd_doc) }, qr/validity?.+error/,
        '... and validation throws an error since the XML is invalid';
};

done_testing();

__DATA__
<?xml version="1.0" encoding="utf-8" ?>
<book>
    <title>XML Validation</title>
    <author>John Example</author>
    <numPages>-200</numPages>
</book>