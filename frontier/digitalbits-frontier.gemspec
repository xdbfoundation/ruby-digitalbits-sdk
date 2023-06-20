# frozen_string_literal: true

require_relative "../base/lib/digitalbits/version"

Gem::Specification.new do |spec|
  spec.name = "digitalbits-frontier"
  spec.version = DigitalBits::VERSION
  spec.authors = ["Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "DigitalBits Frontier client library"
  spec.homepage = "https://github.com/xdbfoundation/ruby-digitalbits-sdk/tree/master/frontier"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"

  spec.metadata = {
    "github_repo" => "ssh://github.com/astroband/ruby-digitalbits-sdk",
    "documentation_uri" => "https://rubydoc.info/gems/digitalbits-sdk/#{spec.version}/",
    "changelog_uri" => "https://github.com/xdbfoundation/ruby-digitalbits-sdk/blob/v#{spec.version}/frontier/CHANGELOG.md",
    "source_code_uri" => "https://github.com/xdbfoundation/ruby-digitalbits-sdk/tree/v#{spec.version}/frontier"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "digitalbits-base", spec.version

  spec.add_dependency "excon", ">= 0.71.0", "< 1.0"
  spec.add_dependency "faraday", ">= 1.6.0", "< 2.0"
  spec.add_dependency "faraday_middleware", ">= 1.1.0", "< 2.0"
  spec.add_dependency "hyperclient", ">= 0.7.0", "< 2.0"
end
