$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "serenity"
  s.version     = "0.2.3"
  s.authors     = "Jeff Coleman"
  s.email       = ""
  s.homepage    = "https://github.com/kremso/serenity"
  s.summary     = "Handles configuration options from Yaml files, returning multi-level values with appropriate error messaging."
  s.description = "Easy work with Smev messages in Ruby."

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_development_dependency "rspec"
  s.add_dependency "rubyzip", '~> 1.0'
end
