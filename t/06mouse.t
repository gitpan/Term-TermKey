#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 11;

use Term::TermKey;

my $tk = Term::TermKey->new_abstract( "vt100", 0 );

$tk->push_bytes( "\e[M \"#" );

my $key;
is( $tk->getkey( $key ), RES_KEY, 'getkey yields RES_KEY after mouse press' );

ok( $key->type_is_mouse,  '$key->type_is_mouse after mouse press' );

is( scalar( my ( $ev, $button, $line, $col ) = $tk->interpret_mouse( $key ) ), 4, '$tk->interpret_mouse yields 4 scalars' );

is( $ev,     MOUSE_PRESS, '$ev after mouse press' );
is( $button, 1,           '$button after mouse press' );
is( $line,   3,           '$line after mouse press' );
is( $col,    2,           '$col after mouse press' );

is( $key->mouseev, MOUSE_PRESS, '$key->mouseev after mouse press' );
is( $key->button,  1,           '$key->button after mouse press' );
is( $key->line,    3,           '$key->line after mouse press' );
is( $key->col,     2,           '$key->col after mouse press' );
