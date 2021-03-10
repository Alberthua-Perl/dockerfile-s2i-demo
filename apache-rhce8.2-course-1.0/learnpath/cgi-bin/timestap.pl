#!/usr/bin/perl

use warnings;
use strict;
use CGI qw(:standard);

print header;
my $now_time = localtime();
print "<b>Hello, CGI using Perl!</b><br><br>It's $now_time now<br>";
