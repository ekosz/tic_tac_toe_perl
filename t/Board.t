use strict;
use warnings;

my @unsolvableBoards = (
  ['', '', '', '', '', '', '', '', ''],          # Empty
  ['x', 'x', 'o', '', '', '', '', '', ''],       # Blocked Win
  ['o', 'x', 'o', 'x', 'x', 'o', 'o', 'o', 'x'], # Cats Game
);

my @solveableBoards = (
  ['x', 'x', 'x', '', '', '', '', '', ''],
  ['', '', '', 'x', 'x', 'x', '', '', ''], # Horizontal
  ['', '', '', '', '', '', 'x', 'x', 'x'],

  ['x', '', '', 'x', '', '', 'x', '', ''], 
  ['', 'x', '', '', 'x', '', '', 'x', ''], # Vertical
  ['', '', 'x', '', '', 'x', '', '', 'x'], 

  ['x', '', '', '', 'x', '', '', '', 'x'], # Diagnal
  ['', '', 'x', '', 'x', '', 'x', '', ' '], 
);

use Test::More;
plan tests => scalar(@unsolvableBoards) + scalar(@solveableBoards) + 6;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::Board') };

use lib 'lib';
use TicTacToe::Board;


foreach my $board (@unsolvableBoards) {
  my @board = @{$board};

  ok !winner( $board ), "@board is not solved";
}

foreach my $board (@solveableBoards) {
  my @board = @{$board};

  is winner( $board ), 'x',  "@board 's winner is x";
}

my @chilrenForOne = children( ['x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ''], 'x' ); 
is_deeply( \@chilrenForOne,
           [ ['x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'] ],
           'Creates a single child, when there is one spot left');

my @childrenForTwo = children( ['x', 'x', 'x', 'x', 'x', 'x', 'x', '', ''], 'x' );
is_deeply( \@childrenForTwo,
           [
             ['x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ''],
             ['x', 'x', 'x', 'x', 'x', 'x', 'x', '', 'x']
           ],
           'Creates a two children, when there is two spots left');

my @childrenForAll = children( ['', '', '', '', '', '', '', '', ''], 'x' );
is_deeply( \@childrenForAll,
           [
             ['x', '', '', '', '', '', '', '', ''],
             ['', 'x', '', '', '', '', '', '', ''],
             ['', '', 'x', '', '', '', '', '', ''],
             ['', '', '', 'x', '', '', '', '', ''],
             ['', '', '', '', 'x', '', '', '', ''],
             ['', '', '', '', '', 'x', '', '', ''],
             ['', '', '', '', '', '', 'x', '', ''],
             ['', '', '', '', '', '', '', 'x', ''],
             ['', '', '', '', '', '', '', '', 'x'],
           ],
           'Creates 9 children, when there is an empty board');

ok !isOver( ['', '', '', '', '', '', '', '', ''] ),
   "An empty board is not over";

ok isOver( ['x', 'x', 'x', '', '', '', '', '', ''] ),
  "A solved board is over";

ok isOver( ['x', 'o', 'x', 'x', 'o', 'x', 'o', 'x', 'o'] ),
  "A cats game is over";
