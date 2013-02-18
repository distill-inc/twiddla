# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twiddla/version"

Gem::Specification.new do |s|
  s.name          = "twiddla"
  s.version       = Twiddla::VERSION
  s.date          = "2013-02-17"
  s.authors       = ["Hwan-Joon Choi"]
  s.email         = ["hc5duke@gmail.com"]
  s.homepage      = "https://github.com/hc5duke/twiddla"

  s.summary       = "Twiddla API ruby wrapper."
  s.description   = "Twiddla API in ruby."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~>2.5"
end
