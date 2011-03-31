require 'mkmf'

dir_config('gmp')
fail "can't find gmp.h, try --with-gmp-include=<path>" unless have_header('gmp.h')
fail "can't find -lgmp, try --with-gmp-lib=<path>" unless have_library('gmp', '__gmpz_init')

create_makefile 'gmp_ffi'
