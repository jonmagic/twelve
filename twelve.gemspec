# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twelve/version"

Gem::Specification.new do |s|
  s.name        = "twelve"
  s.version     = Twelve::VERSION
  s.authors     = ["Jonathan Hoyt"]
  s.email       = ["jonmagic@gmail.com"]
  s.homepage    = "http://github.com/jonmagic/twelve"
  s.summary     = %q{Access Gauges in ruby.}
  s.description = %q{A complete, simple, and intuitive ruby API for all things Gauges.}

  s.rubyforge_project = "twelve"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'faraday_middleware'
  s.add_runtime_dependency 'multi_json'
  s.add_runtime_dependency 'yajl-ruby'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~>2.0'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
end
