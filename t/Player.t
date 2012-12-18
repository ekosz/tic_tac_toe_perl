use strict;
use warnings;

use Test::More tests => 17;

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe::Player') };

use lib 'lib';
use TicTacToe::Player;

{ # Human vs Human
  my $output;
  my $input = "Eric\nAlex\n2\n4\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  my @players = generatePlayers(1, $fakeSTDIN, $fakeSTDOUT);

  is $players[0]->{"name"}, "Eric",
     "Asks player 1 for their name";

  is $players[0]->{"letter"}, "x",
     "Player 1's letter is x";

  is_deeply $players[0]->{"moveSubroutine"}(['', '', '', '', '', '', '', '', '']),
            ['', 'x', '', '', '', '', '', '', ''],
            "Player 1 uses the input stream for their move";

  is $players[1]->{"name"}, "Alex",
     "Asks player 2 for their name";

  is $players[1]->{"letter"}, "o",
     "Player 2's letter is o";

  is_deeply $players[1]->{"moveSubroutine"}(['', '', '', '', '', '', '', '', '']),
            ['', '', '', 'o', '', '', '', '', ''],
            "Player 2 uses the input stream for their move";

}

{ # Human vs Computer
  my $output;
  my $input = "Eric\n1\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  my @players = generatePlayers(2, $fakeSTDIN, $fakeSTDOUT);

  is $players[0]->{"name"}, "Eric",
     "Asks player 1 for their name";

  is $players[0]->{"letter"}, "x",
     "Player 1's letter is x";

  is_deeply $players[0]->{"moveSubroutine"}(['', '', '', '', '', '', '', '', '']),
            ['x', '', '', '', '', '', '', '', ''],
            "Player 1 uses the input stream for their move";

  is $players[1]->{"name"}, "Computer",
     "A computer's name is always Computer";

  is $players[1]->{"letter"}, "o",
     "Player 2's letter is o";

  is_deeply $players[1]->{"moveSubroutine"}(['x', '', '', '', '', '', '', '', '']),
            ['x', '', '', '', 'o', '', '', '', ''],
            "A computer uses the minimax algorithm";

}

{ # Computer vs Computer
  my $output;
  my $input = "";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  my @players = generatePlayers(3, $fakeSTDIN, $fakeSTDOUT);

  is $players[0]->{"name"}, "Computer 1",
     "In computer vs computer, the first computer's name is Computer 1";

  is $players[0]->{"letter"}, "x",
     "Player 1's letter is x";

  is $players[1]->{"name"}, "Computer 2",
     "In computer vs computer, the secound computer's name is Computer 2";

  is $players[1]->{"letter"}, "o",
     "Player 2's letter is o";
}
