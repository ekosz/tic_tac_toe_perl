use strict;
use warnings;

package TicTacToe::MinimaxSolver;
# ABSTRACT: A solver for Tic Tac Toe using the minimax algorithum

use lib 'lib';

use base 'Exporter';
our @EXPORT = qw(nextMove);

use List::Util qw(reduce);
use TicTacToe::Board qw(children isOver);
use TicTacToe::Scorer qw(score);

sub nextMove {
  my $board = shift(@_);
  my $letter = shift(@_);

  my @children = children($board, $letter);

  my $bestChild = reduce { _minimax($a, $letter) > _minimax($b, $letter) ? $a : $b } @children;

  return @{ $bestChild };
}

sub _minimax {
  my $board = shift(@_);
  my $letterToWin = shift(@_);

  return score($board, $letterToWin) if isOver($board);

  my $direction = shift(@_) || 'min';
  my $currentLetter = shift(@_) || _nextLetter($letterToWin);

  my $nextLetter = _nextLetter($currentLetter);
  my $nextDirection = $direction eq 'max' ? 'min' : 'max';

  #print STDERR "\n\nBoard: @{ $board }, Direction: $direction, Letter: $currentLetter\n";

  my @children = children($board, $currentLetter);

  my $score = _minimax($children[0], $letterToWin, $nextDirection, $nextLetter);
  foreach my $child (@children) {
    my $newScore = _minimax($child, $letterToWin, $nextDirection, $nextLetter);

    if ($direction eq 'max') {
      $score = $newScore if($newScore > $score);
    } else {
      $score = $newScore if($newScore < $score);
   }
  }

  return $score;
}

sub _nextLetter {
  my $letter = shift(@_);

  return $letter eq 'x' ? 'o' : 'x';
}

1;
