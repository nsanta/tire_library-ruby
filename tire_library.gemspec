# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tire_library/version"

Gem::Specification.new do |spec|
  spec.name          = "tire_library"
  spec.version       = TireLibrary::VERSION
  spec.authors       = ["Nicolas Santa"]
  spec.email         = ["nicolas55ar@gmail.com"]

  spec.summary       = %q{TireLibrary API client in Ruby}
  spec.description   = %q{Dead simple TireLibrary API client in Ruby}
  spec.homepage      = "https://github.com/nsanta/tire_library"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", '~> 0.49.1'
  spec.add_development_dependency "brakeman"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "httparty", "~>0.15"
  spec.add_runtime_dependency "multi_json", "~> 1.0"
end
