# gmp-ffi

Bindings using FFI for the [GMP](http://gmplib.org/) library.

## Features

* automatic #attach_function
* some spec and test from the original gmp gem (C extension)
* compatibility is tried to be kept with the gmp gem
* faster conversion between GMP::Z and BigNum, if a compiler is available

## What is already done and what is to do

GMP::Z (big integers) and GMP::Q (rationals) are rather functionality-complete.

GMP::F (floats) are not yet implemented.
They are more difficult to implement, as they are implemented in both GMP (limited) and MPFR.
