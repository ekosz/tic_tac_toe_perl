# Tic Tac Toe in Perl

This is a perl module for playing the classic game, Tic Tac Toe.

All code is written in the [Perl Mod Style](http://perldoc.perl.org/perlmodstyle.html).

## Playing the game

Download the source from Github

    ./bin/TicTacToe

Enjoy!

## How to contribute

Download the source from GitHub.  
    
    perl Build.PL #=> Compiles the source
    ./Build test  #=> Runs tests
    perl BuildTest.PL #=> Builds and runs tests

## Useful tidbits

The integration test in ComputerVComputer.t takes about 10 seconds to run.  During development
that is a pain to run every time you want to test. You can use the environment variable
`QUICK_TEST` if you would like to skip all of the slow tests.

    QUICK_TEST=1 perl BuildTest.PL #=> Skipps slow tests
