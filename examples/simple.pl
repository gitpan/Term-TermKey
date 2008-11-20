#!/usr/bin/perl -w

use strict;

use Term::TermKey qw( FLAG_UTF8 RES_EOF KEYMOD_CTRL FORMAT_VIM );

my $tk = Term::TermKey->new(\*STDIN);

# perl sucks and doesn't have a way to do this automatically
binmode( STDOUT, ":utf8" ) if $tk->get_flags & FLAG_UTF8;

while( ( my $ret = $tk->waitkey( my $key ) ) != RES_EOF ) {
   print "Got key: ".$tk->format_key( $key, FORMAT_VIM )."\n";

   last if $key->type_is_unicode and 
           $key->modifiers & KEYMOD_CTRL and 
           $key->codepoint == ord('C');
}
