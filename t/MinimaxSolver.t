use strict;
use warnings;
use Test::More tests => 6;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::MinimaxSolver') };

use lib 'lib';
use TicTacToe::MinimaxSolver;

my @lastMove = nextMove( ['x', 'o', 'x', 'o', 'x', 'o', 'o', '', 'o'], 'x' );
is_deeply(
  \@lastMove,
  ['x', 'o', 'x', 'o', 'x', 'o', 'o', 'x', 'o'],
  "When there is only one spot left, it plays at that spot");

my @winnerMove = nextMove( ['x', 'o', 'x', 'o', 'x', 'o', 'o', '', ''], 'x' );
is_deeply(
  \@winnerMove,
  ['x', 'o', 'x', 'o', 'x', 'o', 'o', '', 'x'],
  'When there is a choice to pick the winning move, it picks that move');

my @losingMove = nextMove( ['o', 'o', 'o', 'x', 'x', 'o', '',  'x', ''], 'x' );
is_deeply(
  \@losingMove,
  ['o', 'o', 'o', 'x', 'x', 'o', '',  'x', 'x'],
  'When there is a choice to stop them from winning, it picks that move');

my @forkingMove = nextMove( ['', '', 'o', '', 'x', '', 'o', '', ''], 'x' );
ok(!eq_array(\@forkingMove, ['x', '', 'o', '', 'x', '', 'o', '', '']) &&
   !eq_array(\@forkingMove, ['', '', 'o', '', 'x', '', 'o', '', 'x']),
   'It does not pick moves that would create a fork on the next turn');

my @cornerStart = nextMove( ['', '', 'x', '', '', '', '', '', ''], 'o' );
is_deeply(
  \@cornerStart,
  ['', '', 'x', '', 'o', '', '', '', ''],
  'Plays in the center when the other player starts in a corner');
