use strict;
use warnings;

package TicTacToe::ErrorHandler;
# ABSTRACT: A set of helper methods for verifiying user input

use base 'Exporter';
our @EXPORT = qw(validCommand freeCell);

sub validCommand {
  my $command = shift(@_);

  return $command =~ /^([1-9]|q)$/
}

sub freeCell {
  my $board    = shift(@_);
  my $position = shift(@_);

  return !$board->[$position];
}

1; # All modules must end with a true value

