
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scythe/version"

Gem::Specification.new do |spec|
  spec.name          = "scythe"
  spec.version       = Scythe::VERSION
  spec.authors       = ["Trent Kocurek"]
  spec.email         = ["t2kocurek@gmail.com"]

  spec.summary       = "A Ruby Wrapper for the Harvest API http://www.getharvest.com/"
  spec.description   = "Scythe wraps the Harvest V2 API concisely without the use of Rails dependencies. More information about the Harvest API can be found on their website (https://help.getharvest.com/api-v2/)."
  spec.homepage      = "http://github.com/zmoazeni/harvested"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.0'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "hashie"
  spec.add_runtime_dependency "json"
end
