use strict;
use warnings;

package TicTacToe::MinimaxSolver;
# ABSTRACT: A solver for Tic Tac Toe using the minimax algorithm

use lib 'lib';

use base 'Exporter';
our @EXPORT = qw(nextMove);

use List::Util qw(reduce);
use TicTacToe::Board qw(children isOver);
use TicTacToe::Scorer qw(score);

our $MAXDEPTH = 6;

sub nextMove {
  my $board = shift(@_);
  my $letter = shift(@_);

  my @children = children($board, $letter);

  my $bestChild = _childWithHighestMinimaxValue(\@children, $letter);

  return @{ $bestChild };
}

sub _childWithHighestMinimaxValue {
  my @children = @{ shift(@_) };
  my $letter   =    shift(@_);

  return reduce { _minimax($a, $letter) > _minimax($b, $letter) ? $a : $b } @children;
}

sub _minimax {
  my $board       = shift(@_);
  my $letterToWin = shift(@_);
  my $depth       = shift(@_) || 1;

  return score($board, $letterToWin, $depth) if isOver($board);

  my $direction     = shift(@_) || 'min';
  my $currentLetter = shift(@_) || _nextLetter($letterToWin);
  my $alpha         = shift(@_) || -9**9;  # Really big low number
  my $beta          = shift(@_) ||  9**9;  # Really big high number

  my $nextLetter    = _nextLetter($currentLetter);
  my $nextDirection = $direction eq 'max' ? 'min' : 'max';

  my @children = children($board, $currentLetter);

  foreach my $child (@children) {
    my $score = _minimax($child, $letterToWin, $depth + 1, $nextDirection, $nextLetter, $alpha, $beta);

    if ($direction eq 'max') {
      $alpha = $score if($score > $alpha);
      last if $beta <= $alpha || $depth  >= $MAXDEPTH; # Break
    } else {
      $beta = $score if($score < $beta);
      last if $alpha >= $beta || $depth >= $MAXDEPTH; # Break
   }
  }

  return $alpha if $direction eq 'max';
  return $beta;
}

sub _nextLetter {
  my $letter = shift(@_);

  return $letter eq 'x' ? 'o' : 'x';
}

1; # All modules must end with a truthy value
