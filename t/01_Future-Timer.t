#!/usr/bin/perl

use strict;
use warnings;

use Test::Most;

use AnyEvent;

BEGIN {
    use_ok('Future::Timer') or exit;
}

subtest 'new()' => sub {
    alarm(10);

    # order of timer/callback triggered
    my $ft_count = 1;

    # timer funtion that will be canceled
    my $w_ft_c = Future::Timer->new(1.5);
    $w_ft_c->on_done(sub   {ok(0,           "should never happen...");});
    $w_ft_c->on_cancel(sub {ok($ft_count++, "future canceled");});

    # cancel first future after one second
    my $w_ft1 = Future::Timer->new(1);
    $w_ft1->on_done(sub {is($ft_count++, 1, "1s is over"); $w_ft_c->cancel;});

    # finish test after 2s
    my $w_ft2 = Future::Timer->new(2);
    $w_ft2->on_done(sub {is($ft_count++, 3, "2s are over");});
    cmp_ok($w_ft2->new, '>=', 2, 'done return value are the seconds passed since start');
};

done_testing();
