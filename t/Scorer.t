use strict;
use warnings;

use Test::More tests => 3;

use lib 'lib';
use TicTacToe::Scorer;

is score(['', '', '', '', '', '', '', '', ''], 'x'), 0, 
   'The score of an empty board is always 0';

is score(['o', 'o', 'o', '', '', '', '', '', ''], 'x'), -1, 
   'The score of a board whose winner is not the given letter is -1';

is score(['x', 'x', 'x', '', '', '', '', '', ''], 'x'), 1, 
  'The score of a board whose winner is the given letter is 1';
