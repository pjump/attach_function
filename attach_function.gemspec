# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ostruct'

gem = OpenStruct.new
gem.name = File.basename(File.dirname(__FILE__))
require "#{gem.name}/version"
gem.module = AttachFunction

Gem::Specification.new do |spec|

  spec.name          = gem.name
  spec.version       = (gem.module)::VERSION
  spec.summary       = %q{True in-place file-editing}
  spec.description   = %q{True in-place file-editing (i.e, inode(input) == inode(output)) like with sed, awk, or `ruby i -{p|n}e`, but truly in-place}

  spec.authors       = ["Petr Skocik"]
  spec.email         = ["pskocik@gmail.com"]
  spec.homepage      = "https://github.com/pjump/#{spec.name}.git"
  spec.licenses      = %w[gplv2]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard", "2.12"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
end
