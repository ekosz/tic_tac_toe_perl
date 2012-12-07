use strict;
use warnings;
use Test::More tests => 2;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::Board') };

use TicTacToe::Board;

my @baseBoard = (undef, undef, undef, undef, undef, undef, undef, undef, undef);

ok( !TicTacToe::Board::isSolved( @baseBoard ) );
