$: << "#{File.dirname(__FILE__)}/lib"
require 'colby'

Gem::Specification.new do |gem|
  gem.authors       = ["Gursimran Singh"]
  gem.email         = ["g@kilotau.com"]
  gem.description   = %q{Small wrapper and functions for persistent, immutable data structures.}
  gem.summary       = %q{Colby makes it easier to work with persistent, immutable data structures.
                         It wraps Hamster's excellent data structures and provides functions to work
                         with them that are similar to Clojure, but not exactly.}
  gem.homepage      = "http://github.com/gnarmis/colby"

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map {|f| File.basename(f)}
  gem.name          = "colby"
  gem.require_paths = ["lib"] 
  gem.version       = Colby::VERSION
end
