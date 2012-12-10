use strict;
use warnings;

package TicTacToe::Scorer;
# ABSTRACT: Set of methods to score TTT Boards

use lib 'lib';
use base 'Exporter';
our @EXPORT = qw(score);

use TicTacToe::Board qw(winner);

sub score {

  my $board  = shift(@_);
  my $letter = shift(@_);
  my $depth  = shift(@_) || 1;

  my $winner = winner($board);
  return 0 unless $winner;

  return 1.0 / $depth if $winner eq $letter;

  -1;
}

1; # All modules most end with a truth value
