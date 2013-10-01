# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parallel_runner/version'

Gem::Specification.new do |spec|
  spec.name          = "parallel_runner"
  spec.version       = ParallelRunner::VERSION
  spec.authors       = ["mapserver2007"]
  spec.email         = ["mapserver2007@gmail.com"]
  spec.description   = %q{Simple parallel processing library.}
  spec.summary       = %q{Simple parallel processing library.}
  spec.homepage      = "https://github.com/mapserver2007/parallel_runner"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mechanize"
  spec.add_development_dependency "rake"
end
