use strict;
use warnings;
use Test::More tests => 18;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::IOHandler') };

use lib 'lib';
use TicTacToe::IOHandler;

{
  my $output;
  my $input = "1\n";
  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  my $board = ['', '', '', '', '', '', '', '', ''];
  
  is retrieveMove($board, 'x', "X", $fakeSTDIN, $fakeSTDOUT), 1,
     "Retrieves the proper move for 1";

  like $output, qr/X, where would you like to play\? \(1-9\): /,
     "Outputs the proper message when retrieving move";
}

{
  my $output;
  my $input = "2\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  my $board = ['', '', '', '', '', '', '', '', ''];
  
  is retrieveMove($board, 'x', "X", $fakeSTDIN, $fakeSTDOUT), 2,
     "Retrieves the proper move for 2";
}

{
  my $output;
  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";

  printBoard(['', '', '', '', '', '', '', '', ''], $fakeSTDOUT);

  is $output, "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n\n",
     "Correctly prints an empty board";
}

{
  my $output;
  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";

  printBoard(['x', '', '', '', 'o', '', '', '', 'x'], $fakeSTDOUT);

  is $output, "x | 2 | 3\n4 | o | 6\n7 | 8 | x\n\n",
     "Correctly prints an board with values";
}

{
  my $output;
  my $input = "yes\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";
  
  ok playAgain($fakeSTDIN, $fakeSTDOUT), 
     "yes is a proper response to play again";

  is $output, "Would you like to play again? (y/n): ",
      "Outputs the proper message for playing again";
}

{
  my $output;
  my $input = "no\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";
  
  ok !playAgain($fakeSTDIN, $fakeSTDOUT), 
     "no is not a response to play again";
}

{
  my $output;
  my $input = "1\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  is getGameMode($fakeSTDIN, $fakeSTDOUT), 1,
     "Retrives the proper game mode for 1";

  is $output, "What type of game would you like to play?\n(1) -- Human     vs   Human\n(2) -- Human     vs   Computer\n(3) -- Computer  vs   Computer\n",
     "Outputs the proper message for choosing a game mode";
 }

 {
   my $output;
   my $input = "2\n";

   open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
   open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

   is getGameMode($fakeSTDIN, $fakeSTDOUT), 2,
      "Retrieves the proper game mode for 2";
}

{ 
  my $output;
  my $input = "Eric\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  is getName("Player 1", $fakeSTDIN, $fakeSTDOUT), "Eric",
     "Properly retrieves a name from the user";

  is $output, "Player 1, what is your name? ",
     "Outputs the proper message for choosing a name";
}

{
  my $output;

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";

  printBadCommand("abc", $fakeSTDOUT);

  is $output, "Sorry, 'abc' is not a proper command\n\n",
     "Prints the proper error message for invalid commands";
}

{
  my $output;

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";

  printTakenSpot($fakeSTDOUT);

  is $output, "Sorry, that spot has already been taken\n\n",
     "Prints the proper error message for taken spots";
}

{
  my $output;

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";

  printGameOver("Eric", $fakeSTDOUT);

  is $output, "Game over. Eric won!",
     "Prints the proper game over message";
}

{
  my $output;

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";

  printThinking("Eric", $fakeSTDOUT);

  is $output, "Eric thinking...\n\n",
     "Prints the proper thinking message";
}
