require_relative 'struct'
require 'ffi'
require 'psych'
require 'yaml'

module GMP
  module Lib
    extend FFI::Library
    ffi_lib 'gmp'

    FunctionsFile = File.expand_path('../../../ffi/functions.yml', __FILE__)
    ConstantsFile = File.expand_path('../../../ffi/constants.yml', __FILE__)
    Functions = YAML.load_file FunctionsFile
    Constants = YAML.load_file ConstantsFile

    Constants.each_pair { |const, value|
      const_set const, value
    }

    class << self
      def method_missing(meth, *args, &block)
        if meth[-1] == '?' # predicate
          fun = meth[0...-1] << '_p'
          define_singleton_method(meth) do |*params|
            send(fun, *params) == 1
          end
        elsif Functions.key?(function = :"__gmp#{meth}")
          params, type = Functions[function]
          attach_function meth, function, params.dup, type
        else
          super
        end
        send(meth, *args, &block)
      end
    end
  end
end
