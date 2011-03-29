header = 'gmp.5.0.1.h'

system 'gcc', '-E', header, '-o', 'gmp.preprocessed.h'

TYPE = /[a-z*\[\]_][ a-z*\[\]_]+/
NAME = /[a-zA-Z*_]+/
PARAM = /\s*
  (?:
    #{TYPE}(?:\s+#{NAME})?
  |
    ...
  )
\s*/x

PROTOTYPE_REGEXP = /^
\s*
  #{TYPE} # function type
\s+
  #{NAME} # function name
\s*
  \( # parameters
    (?:
      \s* # no params
      |
      #{PARAM} # first param
      (?:,#{PARAM})* # other params
    )
  \);
\s*
$/x

prototypes = File.readlines('gmp.preprocessed.h').grep(PROTOTYPE_REGEXP)
puts prototypes


