use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'TicTacToe',
    license             => 'MIT',
    dist_author         => 'Eric Koslow <ekoslow@gamil.com>',
    build_requires => {
        'Test::More' => '0.10',
    },
);

$builder->create_build_script();
