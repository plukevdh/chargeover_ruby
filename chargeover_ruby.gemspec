# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chargeover_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "chargeover_ruby"
  spec.version       = ChargeoverRuby::VERSION
  spec.authors       = ["Buffy Miller"]
  spec.email         = ["buffy@imagerelay.com"]
  spec.description   = %q{Gem to wrap the chargeover.com API}
  spec.summary       = %q{Gem to wrap the chargeover.com API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "ruby-debug-ide"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
