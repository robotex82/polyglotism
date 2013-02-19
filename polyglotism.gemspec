$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "polyglotism/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "polyglotism"
  s.version     = Polyglotism::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/polyglotism"
  s.summary     = "Provides globalization support for activerecord and activemodel"
  s.description = "Provides globalization support for activerecord and activemodel"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"

  # Development server
  s.add_development_dependency "thin"

  # Development database
  s.add_development_dependency "sqlite3"

  # Tests
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails', '~> 2.12.0'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rails', '~> 1.0'

  # Test automation
  # s.add_development_dependency 'guard-rails' # See gemfile for a patched version, for engine support.
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'rb-inotify', '~> 0.8.8'
end

