use strict;
use warnings;
use Test::More tests => 5;

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
