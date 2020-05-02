Gem::Specification.new do |s|
    s.name        = 'rubbyReport'
    s.version     = '0.0.6'
    s.date        = '2020-04-30'
    s.summary     = "Image Reports made easy!"
    s.description = "Generate reports using images and templates in ERB"
    s.authors     = ["Rodrigo Tenorio"]
    s.email       = 'rt3norio@gmail.com'
    s.files       = ["lib/rubbyReport.rb", "lib/templates/basic.html.erb","lib/templates/natu.html.erb"]
    s.homepage    =
      'https://github.com/rt3norio/rubbyReport'
    s.license       = 'MIT'
    s.executables = ["rubbyReport"]
  end