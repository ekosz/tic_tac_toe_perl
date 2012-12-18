use strict;
use warnings;
use Test::More tests => 7;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::ErrorHandler') };

use lib 'lib';
use TicTacToe::ErrorHandler;

ok validCommand("1"), "1 is a valid command";
ok validCommand("q"), "q is a valid command";
ok !validCommand("a"), "A valid command must be a number 1-9 or q";
ok !validCommand("10"), "A number greater than 9 is not a valid command";

ok freeCell(['', '', '', '', '', '', '', '', ''], 1); 
ok !freeCell(['', 'x', '', '', '', '', '', '', ''], 1); 
