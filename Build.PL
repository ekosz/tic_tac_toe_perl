use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'TicTacToe',
    license             => 'mit',
    dist_author         => 'Eric Koslow <ekoslow@gamil.com>',
    dist_abstract       => 'Play Tic Tac Toe in the console!',
    build_requires => {
        'Test::More' => '0.10',
    },
);

$builder->create_build_script();
