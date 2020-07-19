[![Build
Status](https://travis-ci.org/kirklewis/perl5-xml-validation.svg?branch=master)](https://travis-ci.org/kirklewis/perl5-xml-validation)
# Perl 5 XML Validation with DTD and XSD

Code and files used in my [article](https://medium.com/@kirklewis/perl-5-xml-validation-with-dtd-and-xsd-ec2d90f7c434) which briefly covers XML Validation in Perl 5 using `XML::LibXML` modules.

**To Install**

```bash
git clone https://github.com/kirklewis/perl5-xml-validation.git
cd perl5-xml-validation
cpanm -L local --installdeps .
```

_**NB**: You can also create perlbrew lib and install your modules there instead._

**Run Tests**

The test files are located in the [t/](https://github.com/kirklewis/perl5-xml-validation/tree/master/t) directory.

```bash
prove -Ilocal/lib/perl5 -v t/
```

---

Copyright (c) 2020 Kirk Lewis

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
