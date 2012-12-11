use strict;
use warnings;

package TicTacToe::Board;
# ABSTRACT: A set of helper methods for dealing with boards

use base 'Exporter';
our @EXPORT = qw(winner children isOver);

use List::Util qw(reduce);

sub winner { 
  my @winningCombinations = (
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],

    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],

    [0, 4, 8],
    [2, 4, 6],
  );

  my @board = @{ shift(@_) };

  foreach my $winningCombination (@winningCombinations) {
    my @combo = @$winningCombination;

    my $firstCell   = $board[ $combo[0] ];
    my $secondCell  = $board[ $combo[1] ];
    my $thirdCell   = $board[ $combo[2] ];

    if( !_blank($firstCell) && $firstCell eq $secondCell && $secondCell eq $thirdCell ) {
      return $firstCell;
    }
  }

  0; # Did not find a winning combination
}

sub _blank {
  my $string = shift(@_);

  return !$string;
}

sub children {
  my @board = @{ shift(@_) }; 
  my $letter = shift(@_);

  my @toReturn = ();

  for(my $i = 0; $i < scalar(@board); $i++) {
    unless( _cellTaken(\@board, $i) ) {
      my @newBoard = @board;
      $newBoard[$i] = $letter;
      push @toReturn, [ @newBoard ]; # See http://perldoc.perl.org/perllol.html
    }
  }

  return @toReturn;
}

sub _cellTaken {
  my $board   = shift(@_);
  my $locator = shift(@_);

  return $board->[$locator];
}

sub isOver {
  my $board = shift(@_);
  return 1 if winner($board);
  return 1 if _allCellsTaken($board);
  0;
}

sub _allCellsTaken {
  my $board = shift(@_);

  return reduce { $a && $b ? 1 : 0 } @{ $board };
}

1; # All modules must end with a truthy value
