# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack_api_versioning/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nick Zalabak"]
  gem.email         = ["techwhizbang@gmail.com"]
  gem.description   = %q{Version your Rack based API's using headers either through middleware or routing constraints}
  gem.summary       = %q{Version your Rack based API's using headers either through middleware or routing constraints}
  gem.homepage      = "https://github.com/techwhizbang/rack-api-versioning"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-api-versioning"
  gem.require_paths = ["lib"]
  gem.version       = RackApiVersioning::VERSION
  gem.add_dependency %q<rack>, [">= 1.0"]
  gem.add_development_dependency %q<rake>, ["0.9.2.2"]
  gem.add_development_dependency %q<rspec>, ["~> 2.12.0"]
  gem.add_development_dependency %q<rack-test>, ["~> 0.6.2"]
end
