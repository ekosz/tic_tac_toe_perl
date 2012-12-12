use strict;
use warnings;
use Test::More tests => 8;

use lib 'lib';

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe') };

# Verify module can be included via "require" pragma
require_ok( 'TicTacToe' );

use TicTacToe;


{ # Human vs Human
  my $output;
  my $input = "1\nEric\nAlex\n1\n3\n4\n6\n7\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  playTicTacToe($fakeSTDIN, $fakeSTDOUT);

  like $output, qr/Eric won/,
       "Can play a human vs human game to completion";
}

{ # Human vs Computer
  my $output;
  my $input = "2\nEric\n1\n3\nq\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  playTicTacToe($fakeSTDIN, $fakeSTDOUT);

  like $output, qr/Nobody won/,
       "Nobody wins when the user quits early";

  like $output, qr/\| o \|/,
       "The computer player plays in a human vs computer game";
}

{ # Already Taken Spot
  my $output;
  my $input = "1\nEric\nAlex\n1\n1\n2\nq\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  playTicTacToe($fakeSTDIN, $fakeSTDOUT);

  like $output, qr/Sorry, that spot has already been taken/,
       "Notifies users of invalid moves";

  like $output, qr/x \| o/,
       "Does not clober already taken cells";
}

{ # Bad Move
  my $output;
  my $input = "1\nEric\nAlex\na\n1\nq\n";

  open my $fakeSTDOUT, '>', \$output or die "Couldn't open variable: $!";
  open my $fakeSTDIN, '<', \$input or die "Couldn't open variable: $!";

  playTicTacToe($fakeSTDIN, $fakeSTDOUT);

  like $output, qr/Sorry, 'a' is not a proper command/,
       "Notifies users of bad moves";
}
