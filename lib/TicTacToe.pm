use v5.10.0;
use strict;
use warnings;

package TicTacToe;
# ABSTRACT: A Tic Tac Toe game for Perl

$TicTacToe::VERSION = '0.1';

1;

__END__



=head1 SYNOPSIS

    use TicTacToe;

    play_tic_tac_toe();

=head1 DESCRIPTION

Tic Tac Toe is a two player turn based game.  Played since the roman times, players 
take turns each placing their respective symbol until they are able to get three in a
row horizontally, vertically, or diagonally. If the game board fills up before either
player wins, the game is considered a "Cats Game" and neither player win. The game 
board is normally 3x3 in size, but there are variants of Tic Tac Toe that let players
use larger boards.

=head2 Outline Usage

To use TicTacToe simply call the call the play_tic_tac_toe() method. A termainal game
will be started;

    use TicTacToe;

    play_tic_tac_toe();

This module also provides low level functions for automatically solving game boards using
the minimax algorithm.
