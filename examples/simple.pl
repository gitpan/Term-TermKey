#!/usr/bin/perl -w

use strict;

use Term::TermKey qw( FLAG_UTF8 RES_EOF KEYMOD_CTRL FORMAT_VIM );

my $tk = Term::TermKey->new(\*STDIN);

# ensure perl and libtermkey agree on Unicode handling
binmode( STDOUT, ":encoding(UTF-8)" ) if $tk->get_flags & FLAG_UTF8;

while( ( my $ret = $tk->waitkey( my $key ) ) != RES_EOF ) {
   print "Got key: ".$tk->format_key( $key, FORMAT_VIM )."\n";

   last if $key->type_is_unicode and 
           lc $key->utf8 eq "c" and
           $key->modifiers & KEYMOD_CTRL;
}
