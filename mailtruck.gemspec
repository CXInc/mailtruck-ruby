# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailtruck/version'

Gem::Specification.new do |spec|
  spec.name          = "mailtruck"
  spec.version       = Mailtruck::VERSION
  spec.authors       = ["Bruz Marzolf"]
  spec.email         = ["bruz.marzolf@gmail.com"]
  spec.description   = %q{Mailtruck helps with testing features that involve sending and receiving email from external services.}
  spec.summary       = %q{Receive emails from external services for testing}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faye", "~> 0.8"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha", "~> 0.14"
end
