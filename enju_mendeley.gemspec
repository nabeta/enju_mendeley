$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_mendeley/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_mendeley"
  s.version     = EnjuMendeley::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["nabeta@fastmail.fm"]
  s.homepage    = "https://github.com/nabeta/enju_mendeley"
  s.summary     = "Mendeley plugin for Next-L Enju"
  s.description = "Mendeley plugin for Next-L Enju"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "faraday"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.4"
end
