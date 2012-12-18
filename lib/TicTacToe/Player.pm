use strict;
use warnings;

package TicTacToe::Player;
# ABSTRACT: A set of helper methods for dealing with players

our $QUIT_COMMAND = 'q';
our $HUMAN_VS_HUMAN = 1;
our $HUMAN_VS_COMPUTER = 2;

use base 'Exporter';
our @EXPORT = qw(generatePlayers);
use lib 'lib';

use TicTacToe::IOHandler     qw(getName retrieveMove printBoard printThinking 
                                printTakenSpot printBadCommand);
use TicTacToe::ErrorHandler  qw(validCommand freeCell);
use TicTacToe::MinimaxSolver qw(nextMove);

sub generatePlayers {
  my $gameMode      = shift(@_);
  my $inputStream   = shift(@_);
  my $outputStream  = shift(@_);

  my $playerOne;
  my $playerTwo;

  if ($gameMode == $HUMAN_VS_HUMAN)  {
    $playerOne = _generateHuman("Player One", "x", $inputStream, $outputStream);

    $playerTwo = _generateHuman("Player Two", "o", $inputStream, $outputStream);
  } elsif($gameMode == $HUMAN_VS_COMPUTER) {
    $playerOne = _generateHuman("Player One", "x", $inputStream, $outputStream);

    $playerTwo = _generateComputer("Computer", "o", $outputStream);
  } else { # Computer Vs Computer
    $playerOne = _generateComputer("Computer 1", "x", $outputStream);

    $playerTwo = _generateComputer("Computer 2", "o", $outputStream);
  }

  return ($playerOne, $playerTwo);
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
  $human->{"moveSubroutine"} = _generateHumanMoveSubroutine($human, $inputStream, $outputStream);

  return $human;
}

sub _generateHumanMoveSubroutine {
  my $player        = shift(@_);
  my $inputStream   = shift(@_);
  my $outputStream  = shift(@_);

  return sub {
    my $board = shift(@_);
    my $move  = _retrieveValidMove($board, $player, $inputStream, $outputStream);

    return $QUIT_COMMAND if $move eq $QUIT_COMMAND;

    $board->[$move-1] = $player->{"letter"};

    return $board;
  }
}

sub _retrieveValidMove {
  my $board         = shift(@_);
  my $player        = shift(@_);
  my $inputStream   = shift(@_);
  my $outputStream  = shift(@_);

  my $move;

  while (1) {
    $move = retrieveMove($board, $player->{"letter"}, $player->{"name"}, $inputStream, $outputStream);

    last if $move eq $QUIT_COMMAND; # Break

    unless (validCommand($move)) {
      printBadCommand($move, $outputStream);
      next;
    }

    last if freeCell($board, $move-1); # Break
    printTakenSpot($outputStream);
  }

  return $move;
}

sub _generateComputer {
  my $name         = shift(@_);
  my $letter       = shift(@_);
  my $outputStream = shift(@_);

  my $computer = {
    "name"   => $name,
    "letter" => $letter
  };

  $computer->{"moveSubroutine"} = _generateComputerMoveSubroutine($computer, $outputStream);

  return $computer;
}

sub _generateComputerMoveSubroutine {
  my $player       = shift(@_);
  my $outputStream = shift(@_);

  return sub {
    my $board = shift(@_);

    printBoard($board, $outputStream);
    printThinking($player->{'name'}, $outputStream);

    my @nextBoard = nextMove($board, $player->{"letter"});
    return \@nextBoard;
  }
}

1; # All modules must end with a truthy value
