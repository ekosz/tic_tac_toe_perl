use strict;
use warnings;
use Test::More tests => 2;

use lib 'lib';

# Verify module can be included via "use" pragma
BEGIN { use_ok('TicTacToe') };

# Verify module can be included via "require" pragma
require_ok( 'TicTacToe' );
