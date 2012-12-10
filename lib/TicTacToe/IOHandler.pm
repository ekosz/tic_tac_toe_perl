use strict;
use warnings;

package TicTacToe::IOHandler;
# ABSTRACT: A set of helper methods for dealing with the IO operations

use base 'Exporter';
our @EXPORT = qw(retrieveMove printBoard playAgain getGameMode getName);

sub retrieveMove {
  my $board        = shift(@_);
  my $letter       = shift(@_);
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

sub getGameMode {
  my $inputStream  = shift(@_);
  my $outputStream = shift(@_);

  print $outputStream "What type of game would you like to play?\n";
  print $outputStream "(1) -- Human     vs   Human\n";
  print $outputStream "(2) -- Human     vs   Computer\n";
  print $outputStream "(3) -- Computer  vs   Computer\n";
  
  return _readFrom($inputStream);
}

sub getName {
  my $title        = shift(@_);
  my $inputStream  = shift(@_);
  my $outputStream = shift(@_);

  print $outputStream "$title, what is your name? ";

  return _readFrom($inputStream);
}

1; # All modules must end with a true value
