
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "acts/version"

Gem::Specification.new do |spec|
  spec.name          = "acts"
  spec.version       = Version::VERSION
  spec.authors       = ["a.kurdyukov"]
  spec.email         = ["a.kurdyukov@cti.ru"]

  spec.summary       = %q{CLI for automation testing}
  spec.description   = %q{Allow to create new format, form *.rb file for given *.feature file.}
  spec.homepage      = "http://github.com/CarefreeSlacker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = "acts"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
