require 'psych'
require 'yaml'

dir = File.dirname(__FILE__)

header = "#{dir}/gmp.5.0.1.h"
preprocessed = "#{dir}/gmp.preprocessed.h"
functions_file = "#{dir}/functions.yml"

system 'gcc', '-E', header, '-o', preprocessed unless File.exist? preprocessed

TYPE = /(?![ ])[ a-z*\[\]_]+/
NAME = /[a-zA-Z0-9_]+/
PARAM = /
#{TYPE}(?:\s+#{NAME})?
|
...
/x
PARAM_SEPARATOR = /\s*,\s*/

PROTOTYPE_REGEXP = /^
  (?: # function type and name
    (?<type>#{TYPE})\s+(?<name>#{NAME})
    |
    (?<type>#{TYPE}\*)(?<name>#{NAME})
  )
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
  ;
$/x

TYPES_MAP = {
  '...' => :varargs,
  'char *' => :string,
  'long unsigned int' => :ulong,
  'unsigned long int' => :ulong,
  'long int' => :long,
}

%w[void int long double].each { |known| TYPES_MAP[known] = known.to_sym }

%w[int long].each { |known| TYPES_MAP["unsigned #{known}"] = "u#{known}".to_sym }

%w[mpz mpf mpq].each { |kind|
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
  else
    raise "unknown type: #{type}"
  end
end

lines = File.readlines(preprocessed)
lines.each(&:strip!)

lines.each { |line|
  if line.start_with? 'typedef' and line.end_with? ';'
    _, *old_type, new_type = line.split(' ')
    old_type = old_type.join(' ')
    new_type.chop!
    TYPES_MAP[new_type] = type_for(old_type)
  end
}

functions = {}
lines.each { |prototype|
  next unless prototype.end_with?(');') and prototype =~ PROTOTYPE_REGEXP
  # puts prototype
  name, type, params = $~[:name], $~[:type], $~[:params]

  functions[name.to_sym] = [
    params.split(PARAM_SEPARATOR).map { |param| type_for(param) },
    type_for(type)
  ]
}

open(functions_file, 'w') { |f| f.write YAML.dump(functions) }
