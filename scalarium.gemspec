# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scalarium/version"

Gem::Specification.new do |s|
  s.name        = "scalarium_cli"
  s.version     = Scalarium::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Red Davis"]
  s.email       = ["red@railslove.com"]
  s.homepage    = "https://github.com/railslove/Scalarium-CLI"
  s.summary     = %q{Allows you to deploy apps hosted on Scalarium from the command line}
  s.description = %q{Allows you to deploy apps hosted on Scalarium from the command line}

  s.rubyforge_project = "scalarium_cli"

  s.add_dependency "mechanize", "~> 1.0.0"
  s.add_dependency "thor", "~> 0.14.6"

  s.add_development_dependency "rspec", "~> 2.3.0"
  s.add_development_dependency "webmock", "~> 1.6.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
