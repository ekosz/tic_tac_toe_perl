use strict;
use warnings;
use Test::More tests => 1;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::MinimaxSolver') };
