$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "serenity"
  s.version     = "0.2.3"
  s.authors     = "Theo Reichel fork of kremso"
  s.email       = ""
  s.homepage    = "https://github.com/theoo/serenity"
  s.summary     = "Parse ODT file and substitutes placeholders like ERb."
  s.description = "kremso fork with community improvments."

  s.files = Dir["{lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rspec"
  s.add_dependency "rubyzip", '~> 1.0'
  s.add_dependency "nokogiri", '~> 1.0'
end
