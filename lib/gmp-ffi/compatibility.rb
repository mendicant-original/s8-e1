# compatibility with the gmp gem (notably useful for testing)
Dir[File.dirname(__FILE__)+'/compatibility/*.rb'].each { |file| require file }
