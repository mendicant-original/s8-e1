# gmp-ffi

Bindings using FFI for the [GMP](http://gmplib.org/) library.

## Features

* automatic #attach_function
* some spec and test from the original gmp gem (C extension)
* compatibility is tried to be kept with the gmp gem
* faster conversion between GMP::Z and BigNum, if a compiler is available

## Synopsis

    require_relative 'path/to/lib/gmp-ffi'
    f = GMP::F.new(3.14) # or GMP::F(3.14)
    2 * f # => 6.28
    (f / 3) * 3 # => 3.14 (and not 3.1399999999999997 with Float)
    -f / Math::PI # => -0.9994930426171028

## What is already done and what is to do

GMP::Z (big integers) and GMP::Q (rationals) are rather functionality-complete.

GMP::F (floats) are being implemented.
They are more difficult to implement, as they are implemented in both GMP (limited) and MPFR.

## Project structure

The project structure is a bit unusual: methods for the 3 numeric types (Z, Q and F) are split by concept.
This makes easier to find/add a method and avoid having one big file.
