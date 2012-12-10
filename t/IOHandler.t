use strict;
use warnings;
use Test::More tests => 9;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::IOHandler') };

use lib 'lib';
use TicTacToe::IOHandler;

{
  my $output;
  my $input = "1\n";
  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";
  
  is retrieveMove("X", $fakeSTDIN, $fakeSTDOUT), 1,
     "Retrives the proper move for 1";

  is $output, "X, where would you like to play? (1-9): ",
     "Outputs the proper message when retrieving move";
}

{
  my $output;
  my $input = "2\n";
  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";
  
  is retrieveMove("X", $fakeSTDIN, $fakeSTDOUT), 2,
     "Retrives the proper move for 2";
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
