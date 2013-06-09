# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_hen/version'

Gem::Specification.new do |spec|
  spec.name          = "acts-as-time-hen"
  spec.version       = ::TimeHen::VERSION
  spec.authors       = ["Dan Nguyen"]
  spec.email         = ["dansonguyen@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', "~>2.8"
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'database_cleaner', "~>0.7.1"
  spec.add_development_dependency 'sqlite3', "~>1.3.5"

  spec.add_dependency 'activerecord'
  spec.add_dependency 'chronic'
  spec.add_dependency 'activesupport'

end
