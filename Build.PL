use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name        => 'Future::Timer',
    license            => 'perl',
    dist_author        => 'Jozef Kutej <jkutej@cpan.org>',
    dist_version_from  => 'lib/Future/Timer.pm',
    configure_requires => {'Module::Build' => '0.3607',},
    requires           => {
        'Future'           => '0.47',
        'AnyEvent'         => '7.17',
        'AnyEvent::Future' => '0.04',
        'Carp'             => '1.50',
        'Time::HiRes'      => '1.972101',
    },
    build_requires => {'Test::Most' => '0.25',},
    add_to_cleanup => ['Future-Timer-*'],
    create_readme  => 1,
    meta_merge     => {
        resources => {
            repository => 'https://github.com/jozef/Future-Timer',
            bugtracker => 'https://github.com/jozef/Future-Timer/issues',
        },
        keywords => [qw/ future timer async /],
    },
);

$builder->create_build_script();
