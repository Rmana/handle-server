lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'handle-server/version'

Gem::Specification.new do |gem|
  gem.name          = "handle-server"
  gem.version       = HandleServer::VERSION
  gem.authors       = ["Howard Ding"]
  gem.email         = ["hding2@illinois.edu"]
  gem.description   = %q{Client for UIUC handle server}
  gem.summary       = %q{Client for UIUC handle server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "httparty"
end
