use 5.010;
use strict;
use warnings;

package TicTacToe;
# ABSTRACT: A Tic Tac Toe game for Perl

$TicTacToe::VERSION = '0.1';

our $QUIT_COMMAND = 'q';
our $HUMAN_VS_HUMAN = 1;
our $HUMAN_VS_COMPUTER = 2;

use base 'Exporter';
our @EXPORT = qw(playTicTacToe);
use lib 'lib';

use TicTacToe::IOHandler qw(getGameMode printGameOver printBoard);
use TicTacToe::Board     qw(isOver winner);
use TicTacToe::Player    qw(generatePlayers);

sub playTicTacToe {
  my $inputStream  = shift(@_) || *STDIN;
  my $outputStream = shift(@_) || *STDOUT;
  my $board        = ['', '', '', '', '', '', '', '', '']; 
  
  my $gameMode      = getGameMode($inputStream, $outputStream);
  my @players       = generatePlayers($gameMode, $inputStream, $outputStream);
  my $playerOne     = $players[0];
  my $playerTwo     = $players[1];
  my $currentPlayer = $playerOne;

  until( isOver($board) ) {
    my $nextBoard = $currentPlayer->{"moveSubroutine"}($board);

    last if $nextBoard eq $QUIT_COMMAND; # Break

    $board         = $nextBoard;
    $currentPlayer = _nextPlayer($currentPlayer, $playerOne, $playerTwo);
  }

  printBoard($board, $outputStream);

  my $winner = _winner($board, $playerOne, $playerTwo);
  printGameOver($winner, $outputStream);
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
