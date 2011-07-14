require_relative 'struct'
require 'ffi'
require 'psych'
require 'yaml'

module GMP
  module Mpfr
    extend FFI::Library
    ffi_lib 'mpfr'

    enum :mpfr_rnd_t,
      :RNDN, # round to nearest, with ties to even
      :RNDZ, # round toward zero
      :RNDU, # round toward +Inf
      :RNDD, # round toward -Inf
      :RNDA, # round away from zero
      :RNDF, # faithful rounding (not implemented yet)
      -1, :RNDNA # round to nearest, with ties away from zero (mpfr_round)

    class << self
      def method_missing(meth, *args, &block)
        if meth[-1] == '?' # predicate
          fun = meth[0...-1] << '_p'
          define_singleton_method(meth) do |*params|
            send(fun, *params) == 1
          end
        elsif Lib::Functions.key?(function = :"mpfr_#{meth}")
          params, type = Lib::Functions[function]
          attach_function meth, function, params.dup, type
        else
          super
        end
        send(meth, *args, &block)
      end
    end
  end
end
