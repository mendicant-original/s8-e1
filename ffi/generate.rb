require 'psych'
require 'yaml'

dir = File.dirname(__FILE__)

gmp_header = "#{dir}/gmp.5.0.1.h"
header = "#{dir}/mpfr.3.0.0.h" # let's use mpfr as it includes gmp.h

preprocessed_header = "#{dir}/gmp.preprocessed.h"

functions_file = "#{dir}/functions.yml"
constants_file = "#{dir}/constants.yml"

system 'gcc', '-E', header, '-o', preprocessed_header unless File.exist? preprocessed_header

TYPE = /(?![ ])[ a-z*\[\]_]+/
NAME = /[a-zA-Z0-9_]+/
PARAM = /
#{TYPE}(?:\s+#{NAME})?
|
...
/x
PARAM_SEPARATOR = /\s*,\s*/

PROTOTYPE_REGEXP = /
  (?: # function type and name
    (?<type>#{TYPE})\s+
    |
    (?<type>#{TYPE}\*)
  )
  (?<name>#{NAME})
\s*
  \( # parameters
    (?<params>
      \s* # no params
      |
      \s*
      #{PARAM} # first param
      (?:#{PARAM_SEPARATOR}#{PARAM})* # other params
      \s*
    )
  \)
  (?:[ ]__attribute__[ ]\(\(__pure__\)\))?
  ;\s+
/x

TYPES_MAP = {
  '...' => :varargs,
  'char *' => :string,
  'char*' => :string,
  'long unsigned int' => :ulong,
  'unsigned long int' => :ulong,
  'long int' => :long,
  'long double' => :long_double,
  'mpfr_rnd_t' => :mpfr_rnd_t, # enum
}

%w[void int long float double].each { |known| TYPES_MAP[known] = known.to_sym }

%w[int long].each { |known| TYPES_MAP["unsigned #{known}"] = "u#{known}".to_sym }

%w[mpz mpf mpq mpfr].each { |kind|
  TYPES_MAP["#{kind}_ptr"] = :pointer
  TYPES_MAP["#{kind}_srcptr"] = :pointer
  # fallback
  TYPES_MAP["#{kind}_t"] = :pointer
  TYPES_MAP["__#{kind}_struct"] = :pointer
}

IGNORE = <<IGNORE.lines.map(&:chomp)
__gmp_randstate_struct
gmp_randstate_t
gmp_randalg_t
IGNORE

IGNORED_MOFIFIERS = %w[signed const]

def type_for type
  if type.include? ' '
    type = (type.split(' ') - IGNORED_MOFIFIERS).join(' ')
  end

  if t = TYPES_MAP[type]
    t
  elsif type.include? '*'
    :pointer
  elsif IGNORE.include? type
    :pointer
  elsif t = TYPES_MAP[type.split(' ')[0...-1].join(' ')] # remove var name
    t
  else
    raise "unknown type: #{type}"
  end
end

preprocessed = File.read(preprocessed_header)

gmp_header_lines = File.readlines(gmp_header)

preprocessed.lines.each { |line|
  line.chomp!
  if line.start_with? 'typedef' and line.end_with? ';'
    _, *old_type, new_type = line.split(' ')
    old_type = old_type.join(' ')
    new_type.chop!
    TYPES_MAP[new_type] = type_for(old_type)
  end
}

functions = {}
preprocessed.scan(PROTOTYPE_REGEXP) { |*e|
  name, type, params = $~[:name], $~[:type], $~[:params]

  functions[name.to_sym] = [
    params.split(PARAM_SEPARATOR).map { |param| type_for(param) },
    type_for(type)
  ]
}

constants = {}
[:GMP_CC, :GMP_CFLAGS].each { |const|
  gmp_header_lines.find { |line|
    line =~ /^#define __#{const} "(.+)"$/
    constants[const] = $1
  }
}
require 'ffi'
module Lib
  extend FFI::Library
  ffi_lib 'gmp'
  attach_variable :gmp_version, :__gmp_version, :string
  attach_variable :gmp_bits_per_limb, :__gmp_bits_per_limb, :int
end

constants[:GMP_VERSION] = Lib.gmp_version
constants[:GMP_BITS_PER_LIMB] = Lib.gmp_bits_per_limb

open(functions_file, 'w') { |f| f.write YAML.dump(functions) }
open(constants_file, 'w') { |f| f.write YAML.dump(constants) }
