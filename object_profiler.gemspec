# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object/profiler/version'

Gem::Specification.new do |spec|
  spec.name          = "object_profiler"
  spec.version       = ObjectProfiler::VERSION
  spec.authors       = ["Tieg Zaharia"]
  spec.email         = ["tieg.zaharia@gmail.com"]
  spec.description   = %q{Object::Profiler uses DTrace probes in Ruby 2.0 to help instrument your code.}
  spec.summary       = %q{Object::Profiler uses DTrace probes in Ruby 2.0 to help instrument your code.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
