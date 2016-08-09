# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nfe/version'

Gem::Specification.new do |spec|
  spec.name          = 'nfe'
  spec.version       = Nfe::VERSION
  spec.authors       = ['Luis Tofoli']
  spec.email         = ['tofoli.luis@gmail.com']

  spec.summary       = %q{API to validate the signature of an XML of NF-e}
  spec.description   = %q{API to validate the signature of an XML of NF-e}
  spec.homepage      = 'https://github.com/tofoli/nfe'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'nokogiri', '~> 1.5'
end
