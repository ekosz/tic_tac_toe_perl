use strict;
use warnings;
use Test::Slow;
use Test::More tests => 3;

use lib 'lib';
use TicTacToe::Board qw(isOver);
use TicTacToe::MinimaxSolver qw(nextMove);
use TicTacToe::Scorer qw(score);

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe') };

# Verify module can be included via "require" pragma
require_ok( 'TicTacToe' );

my $computerVsComputer = ['', '', '', '', '', '', '', '', '']; 
my $currentPlayer = 'x';
while ( !isOver($computerVsComputer) ) {
  my @nextBoard = nextMove($computerVsComputer, $currentPlayer);
  $computerVsComputer = \@nextBoard;
  $currentPlayer = $currentPlayer eq 'x' ? 'o' : 'x';
}

ok score($computerVsComputer, 'x') == 0 && score($computerVsComputer, 'o') == 0,
   "When a computer player plays another computer, the final board is always a cats game";
