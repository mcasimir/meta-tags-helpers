# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "meta-tags-helpers"
  spec.version       = "0.1.7"
  spec.authors       = ["mcasimir"]
  spec.email         = ["maurizio.cas@gmail.com"]
  spec.description   = "Rails meta tags helpers"
  spec.summary       = "Seo and future-proof meta tags for Rails"
  spec.homepage      = "https://github.com/mcasimir/meta-tags-helpers"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "combustion", "~> 0.5.1"

end
