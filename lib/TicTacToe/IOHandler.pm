use strict;
use warnings;

package TicTacToe::IOHandler;
# ABSTRACT: A set of helper methods for dealing with the IO operations

use base 'Exporter';
our @EXPORT = qw(retrieveMove printBoard playAgain);

sub retrieveMove {
  my $name         = shift(@_);
  my $inputStream  = shift(@_);
  my $outputStream = shift(@_);

  print $outputStream "$name, where would you like to play? (1-9): ";

  my $input = _readFrom($inputStream);

  return $input;
}

sub _readFrom {
  my $inputStream  = shift(@_);
  my $input = <$inputStream>;
  return _stripWhitespace($input);
}

sub _stripWhitespace {
  my $string = shift(@_);

  $string =~ s/^\s*(.*)\s*$/$1/; # Strip whitespace from both sides

  return $string;
}


sub printBoard {
  my $board        = shift(@_);
  my $outputStream = shift(@_);

  my $printedBoard = '';

  for my $i (0..2) {
    for my $j (0..2) {
      my $currentPosition = 3*$i + $j;
      my $cell            = $board->[$currentPosition];

      $printedBoard .= $cell ? $cell : $currentPosition + 1;
      $printedBoard .= " | " unless _lastColumn($j);
    }
    $printedBoard .= "\n";
  }
  $printedBoard .= "\n";

  print $outputStream $printedBoard;
}

sub _lastColumn {
  my $columnNum = shift(@_);

  return $columnNum >= 2;
}

sub playAgain {
  my $inputStream  = shift(@_);
  my $outputStream = shift(@_);
  
  print $outputStream "Would you like to play again? (y/n): ";

  my $input = _readFrom($inputStream);

  return $input =~ /^y(es)?$/i;
}

1; # All modules must end with a true value
