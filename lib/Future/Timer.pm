package Future::Timer;

use warnings;
use strict;
use utf8;

use Future;
use AnyEvent;
use AnyEvent::Future;
use Carp qw(croak);
use Time::HiRes qw(time);

our $VERSION = '0.01';

sub new {
    my ($class, $seconds) = @_;

    croak 'needs seconds as argument'
        if !defined($seconds);

    my $w_ft  = AnyEvent::Future->new;
    my $start = time();
    my $w;
    $w = AnyEvent->timer(
        after => $seconds,
        cb    => sub {
            $w = undef;
            $w_ft->done(time() - $start)
                unless $w_ft->is_ready;
        }
    );

    return $w_ft;
}

1;

__END__

=head1 NAME

Future::Timer - timer implemented as Future

=head1 SYNOPSIS

    use Future::Timer;
    
    my $w_ft = Future::Timer->new(60);
    $w_ft->on_done(sub { say "60 seconds are over" });

=head1 DESCRIPTION

Simple L<Future> wrapper around L<AnyEvent/TIME-WATCHERS>.

=head1 METHODS

=head2 new($seconds)

Will return L<Future> that will be done in C<$seconds>.

=head1 SEE ALSO

Same as:

    use Future::IO;
    my $w_ft = Future::IO->sleep($seconds);

=head1 AUTHOR

Jozef Kutej, C<< <jkutej at cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2021 jkutej@cpan.org

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
