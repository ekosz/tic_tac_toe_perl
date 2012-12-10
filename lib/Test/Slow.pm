package Test::Slow;

use strict;
use Test::More;

BEGIN {
  plan(skip_all => 'Slow test.') if $ENV{QUICK_TEST};
}

1;
