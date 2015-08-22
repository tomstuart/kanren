lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kanren/version'

Gem::Specification.new do |spec|
  spec.name          = 'kanren'
  spec.version       = Kanren::VERSION
  spec.author        = 'Tom Stuart'
  spec.email         = 'tom@codon.com'

  spec.summary       = 'An example Ruby implementation of μKanren.'
  spec.homepage      = 'https://github.com/tomstuart/kanren'
  spec.license       = 'CC0-1.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
end
