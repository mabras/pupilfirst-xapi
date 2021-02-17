require_relative "lib/pupilfirst_xapi/version"

Gem::Specification.new do |spec|
  spec.name        = "pupilfirst_xapi"
  spec.version     = PupilfirstXapi::VERSION
  spec.authors     = ["GrowthTribe"]
  spec.email       = ["devs@growthtribe.io"]
  spec.homepage    = "https://github.com/growthtribeacademy/pupilfirst-xapi"
  spec.summary     = "XAPI statements generator and publisher to LRS for Pupilfirst"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/growthtribeacademy/pupilfirst-xapi/pupilfirst_xapi"
  spec.metadata["changelog_uri"] = "https://github.com/growthtribeacademy/pupilfirst-xapi/pupilfirst_xapi/CHANGELOG"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"

  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'dotenv-rails'
  spec.add_development_dependency 'webmock'
end
