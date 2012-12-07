use strict;
use warnings;

package TicTacToe::Scorer;
# ABSTRACT: Set of methods to score TTT Boards

use lib 'lib';
use base 'Exporter';
our @EXPORT = qw(score);

use TicTacToe::Board qw(winner);

sub score {
  my @board = @{ shift(@_) };
  my $letter = shift(@_);

  my $winner = winner(@board);
  return 0 unless $winner;

  return 1 if $winner eq $letter;

  -1;
}

1;