use strict;
use warnings;
use utf8;
use Test::More;

use Monad::Lazy;

subtest 'basic' => sub {
    my $lazy = Monad::Lazy::mreturn(30);

    is $lazy->eval, 30;
};

done_testing;
