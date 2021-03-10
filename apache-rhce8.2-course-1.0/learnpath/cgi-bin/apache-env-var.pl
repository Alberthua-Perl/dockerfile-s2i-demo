#!/usr/bin/perl

use strict;
use warnings;

print "Content-type: text/html\n\n";
# Must be added one blank line after Content-type to use "\n\n".
foreach my $key (keys %ENV) {
		print "$key --> $ENV{$key}<br>";
		# Use <br> tag like the action of "\n", not to use "\n".
}
