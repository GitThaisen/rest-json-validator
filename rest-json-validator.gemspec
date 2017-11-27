Gem::Specification.new do |s|
  s.name        = 'rest-json-validator'
  s.version     = '0.0.3'
  s.date        = '2017-11-27'
  s.summary     = "Tool to test a json structure and data against a specification"
  s.description = "Define a specification of a json structure, as well as composing methods to verify its content. Then use this tool to recursively run through the data, and validate it matches your specification. We've used this extensively to verify json API responses at NRK."
  s.authors     = ["John Åsmund Westberg, Aril Spetalen, Magnus de Laval, Dagfinn Olsen"]
  s.email       = 'dagfinno@gmail.com'
  s.files       = ["lib/rest-json-validator.rb"]
  s.homepage    = 'http://github.com/nrkno/rest-json-validator'
  s.license     = 'MIT'
end
