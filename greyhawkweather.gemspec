# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "greyhawkweather/version"

Gem::Specification.new do |s|
  s.name        = "greyhawkweather"
  s.version     = Greyhawkweather::VERSION
  s.authors     = ["Mark Simpson"]
  s.email       = ["verdammelt@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Generates randomized weather based upon the 1983 Greyhawk boxed set.}
  s.description = <<-EOF
    Using this gem one can generate randomized weather based upon the 
    rules found in the 1983 boxed set.

    Currently not all features of those rules are applied.

    Future plans include the ability to choose different months and 
    weather chances instead of only those from Greyhawk.
  EOF

  s.rubyforge_project = "greyhawkweather"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "rangehash", ">=0.0.5"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rcov"
  s.add_development_dependency "rake"
end
