use 5.010;
use strict;
use warnings;

package TicTacToe;
# ABSTRACT: A Tic Tac Toe game for Perl

$TicTacToe::VERSION = '0.1';

use base 'Exporter';
our @EXPORT = qw(playTicTacToe);
use lib 'lib';

use TicTacToe::IOHandler qw(getGameMode getName retrieveMove printBoard);
use TicTacToe::Board qw(isOver winner);
use TicTacToe::MinimaxSolver qw(nextMove);

sub playTicTacToe {
  my $inputStream  = shift(@_) || *STDIN;
  my $outputStream = shift(@_) || *STDOUT;
  my $board        = ['', '', '', '', '', '', '', '', '']; 
  
  my $gameMode     = getGameMode($inputStream, $outputStream);
  my $playerOne;
  my $playerTwo;

  if ($gameMode == 1)  {
    $playerOne = _generateHuman("Player One", "x", $inputStream, $outputStream);

    $playerTwo = _generateHuman("Player Two", "o", $inputStream, $outputStream);
  } elsif($gameMode == 2) {
    $playerOne = _generateHuman("Player One", "x", $inputStream, $outputStream);

    $playerTwo = _generateComputer("Computer", "o", $outputStream);
  } else {
    $playerOne = _generateComputer("Computer 1", "x", $outputStream);

    $playerTwo = _generateComputer("Computer 2", "o", $outputStream);
  }

  my $currentPlayer = $playerOne;

  while(!isOver($board)) {
    my $nextBoard = $currentPlayer->{"move"}($board);

    last if $nextBoard eq 'q'; # Quit the game on q

    $board         = $nextBoard;
    $currentPlayer = _nextPlayer($currentPlayer, $playerOne, $playerTwo);
  }

  printBoard($board, $outputStream);

  my $winner = _winner($board, $playerOne, $playerTwo);
  print $outputStream "Game over. $winner won!";
}

sub _nextPlayer {
  my $currentPlayer = shift(@_);
  my $playerOne     = shift(@_);
  my $playerTwo     = shift(@_);

  return $currentPlayer == $playerOne ? $playerTwo : $playerOne;
}

sub _winner {
  my $board     = shift(@_);
  my $playerOne = shift(@_);
  my $playerTwo = shift(@_);

  my $winningLetter = winner($board);
  return "Nobody" unless $winningLetter;

  return $playerOne->{"name"} if $playerOne->{"letter"} eq $winningLetter;
  return $playerTwo->{"name"} if $playerTwo->{"letter"} eq $winningLetter;
  die "Invalid winning letter: $winningLetter. $!";
}

sub _generateHuman {
  my $name         = shift(@_);
  my $letter       = shift(@_);
  my $inputStream  = shift(@_);
  my $outputStream = shift(@_);

  my $human = {
    "name"   => getName($name, $inputStream, $outputStream),
    "letter" => $letter
  };
  $human->{"move"} = _generateHumanMoveSubroutine($human, $inputStream, $outputStream);

  return $human;
}

sub _generateHumanMoveSubroutine {
  my $player        = shift(@_);
  my $inputStream   = shift(@_);
  my $outputStream  = shift(@_);

  return sub {
    my $board = shift(@_);
    my $move = retrieveMove($board, $player->{"letter"}, $player->{"name"}, $inputStream, $outputStream);

    return 'q' if $move eq 'q';

    $board->[$move-1] = $player->{"letter"};

    return $board;
  }
}

sub _generateComputer {
  my $name         = shift(@_);
  my $letter       = shift(@_);
  my $outputStream = shift(@_);

  my $computer = {
    "name"   => $name,
    "letter" => $letter
  };

  $computer->{"move"} = _generateComputerMoveSubroutine($computer, $outputStream);

  return $computer;
}

sub _generateComputerMoveSubroutine {
  my $player       = shift(@_);
  my $outputStream = shift(@_);

  return sub {
    my $board = shift(@_);

    printBoard($board, $outputStream);
    print $outputStream "$player->{'name'} thinking...\n\n";

    my @nextBoard = nextMove($board, $player->{"letter"});
    return \@nextBoard;
  }
}

1; # All modules must end with truthy value

__END__

=head1 NAME

Tic Tac Toe

=head1 SYNOPSIS

    use TicTacToe;

    playTicTacToe();

=head1 DESCRIPTION

Tic Tac Toe is a two player turn based game.  Played since the roman times, players 
take turns each placing their respective symbol until they are able to get three in a
row horizontally, vertically, or diagonally. If the game board fills up before either
player wins, the game is considered a "Cats Game" and neither player win. The game 
board is normally 3x3 in size, but there are variants of Tic Tac Toe that let players
use larger boards.

=head2 Outline Usage

To use TicTacToe simply call the call the playTicTacToe() method. A terminal game
will be started;

    use TicTacToe;

    playTicTacToe();

This module also provides low level functions for automatically solving game boards using
the minimax algorithm.

=head2 Methods

=over 12

=item C<playTicTacToe>

Starts the Tic Tac Toe game.  It takes an input stream and an output stream as arguments.
The defaults are STDIN and STDOUT.

=back

=head1 AUTHOR

Eric Koslow <http://github.com/ekosz/>
