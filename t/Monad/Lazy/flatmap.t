use strict;
use warnings;
use utf8;
use Test::More;

use Monad::Lazy;

subtest 'basic' => sub {
    my $lazy = Monad::Lazy::mreturn(100);
    my $f = sub {
        my $int = shift;
        Monad::Lazy::mreturn($int * 3);
    };

    my $flatmapped = $lazy->flatmap($f);

    is $flatmapped->eval, 300;
    is $lazy->eval, 100;        # immutable
};

subtest 'chain' => sub {
    my $lazy = Monad::Lazy::mreturn(10);
    my $f1 = sub { Monad::Lazy::mreturn($_[0] + 10) };
    my $f2 = sub { Monad::Lazy::mreturn($_[0] + 15 ) };
    my $f3 = sub { Monad::Lazy::mreturn($_[0] * 2) };

    my $flatmapped =
        $lazy
            ->flatmap($f1)
            ->flatmap($f2)
            ->flatmap($f3);

    is $flatmapped->eval, 70;
    is $lazy->eval, 10;
};

done_testing;
