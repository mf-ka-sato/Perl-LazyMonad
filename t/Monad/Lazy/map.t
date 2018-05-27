use strict;
use warnings;
use utf8;
use Test::More;

use Monad::Lazy;

subtest 'basic' => sub {
    my $lazy = Monad::Lazy::mreturn(100);
    my $mapped = $lazy->map(sub { $_[0] * 2 });

    is $mapped->eval, 200;
    is $lazy->eval, 100;        # immutable
};

subtest 'chain' => sub {
    my $lazy = Monad::Lazy::mreturn(50);
    my $mapped =
        $lazy
            ->map(sub { $_[0] + 2 })
            ->map(sub { $_[0] * 10 })
            ->map(sub { $_[0] + 5 });

    is $mapped->eval, 525;
    is $lazy->eval, 50;
};

done_testing;
