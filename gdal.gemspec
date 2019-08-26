$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "gdal/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gdal"
  s.version     = Gdal::VERSION
  s.authors     = ["saurabh"]
  s.email       = ["saurabhgulati159@gmail.com"]
  s.homepage    = "http://droneview.com"
  s.summary     = "Summary of Gdal."
  s.description = "Description of Gdal."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"
  s.add_dependency "rspec"
  
  s.add_development_dependency "sqlite3"
end
