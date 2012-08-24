SPEC = Gem::Specification.new do |s|
  s.name = "serenity-odt"
  s.version = "0.2.2"
  s.date = "2012-08-24"
  s.author = "Jeff Coleman"
  s.email = ""
  s.homepage = "https://github.com/kremso/serenity"
  s.platform = Gem::Platform::RUBY
  s.summary = "Handles configuration options from Yaml files, returning multi-level values with appropriate error messaging."
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = "lib"
  s.has_rdoc = false
  s.add_dependency("rspec", ">= 1.2.6")
end