# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gamercard/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["Matt Wilson"]
  s.email         = ["mhw@hypomodern.com"]
  s.description   = %q{TODO: Write a gem description}
  s.summary       = %q{TODO: Write a gem summary}
  s.homepage      = "https://github.com/hypomodern/gamercard"

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.name          = "gamercard"
  s.require_paths = ["lib"]
  s.version       = Gamercard::VERSION

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'typhoeus'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'fakeweb'

  s.add_dependency 'nokogiri'
  s.add_dependency 'faraday', '>= 0.8.0.rc2'
end
