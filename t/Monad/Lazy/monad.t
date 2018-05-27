use strict;
use warnings;
use utf8;
use Test::More;

use Monad::Lazy;

# Monad則のテスト

subtest 'return x >>= f == f x' => sub {
    my $x = 50;
    my $f = sub {
        my $int = shift;
        $int *= 2;
        Monad::Lazy::mreturn($int);
    };

    my $left  = Monad::Lazy::mreturn($x)->flatmap($f);
    my $right = $f->($x);

    is $left->eval, $right->eval;
};

subtest 'm >>= return == m' => sub {
    my $m = Monad::Lazy::mreturn(40);

    my $left  = $m->flatmap(\&Monad::Lazy::mreturn); 
    my $right = $m;

    is $left->eval, $right->eval;
};

subtest '(m >>= f) >>= g == m >>= (\x -> f x >>= g)' => sub {
    my $m = Monad::Lazy::mreturn(100);
    my $f = sub {
        my $int = shift;
        $int *= 2;
        Monad::Lazy::mreturn($int);
    };
    my $g = sub {
        my $int = shift;
        $int += 10;
        Monad::Lazy::mreturn($int);
    };

    my $left  = ($m->flatmap($f))->flatmap($g);
    my $right = $m->flatmap(sub { $f->($_[0])->flatmap($g) });

    is $left->eval, $right->eval;
};

done_testing;
