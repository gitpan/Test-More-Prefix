#!perl

use strict;
use warnings;

use Test::More;
use Test::More::Prefix qw/test_prefix/;

plan skip_all => 'TB2 tests' unless $Test::Builder::VERSION > 1;

my $log = TB2::Event::Log->new( level => 'notice', message => 'foo');
is($log->message, 'foo', "Pre-prefix unchanged");

test_prefix("Bar");
$log->message("Foo");
is($log->message, "Bar: Foo", "Prefix used for msg change");

test_prefix("Baz");
is(
    TB2::Event::Log->new( level => 'notice', message => 'foo')->message,
    'Baz: foo',
    "Prefix works with constructor"
);

done_testing;
