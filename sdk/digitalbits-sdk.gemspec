# frozen_string_literal: true

require_relative "../base/lib/digitalbits/version"

Gem::Specification.new do |spec|
  spec.name = "digitalbits-sdk"
  spec.version = Digitalbits::VERSION
  spec.authors = ["XDB Foundation"]
  spec.summary = "DigitalBits client library"
  spec.homepage = "https://github.com/xdbfoundation/ruby-digitalbits-sdk"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/sdk/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/#{spec.name}/#{spec.version}/",
    "github_repo" => spec.homepage.sub("https", "ssh"),
    "homepage_uri" => "#{spec.homepage}/tree/main/sdk",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}/sdk"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "digitalbits-base", spec.version

  spec.add_dependency "activesupport", ">= 5.0.0", "< 7.0"
  spec.add_dependency "excon", ">= 0.71.0", "< 1.0"
  spec.add_dependency "hyperclient", ">= 0.7.0", "< 2.0"
  spec.add_dependency "toml-rb", ">= 1.1.1", "< 3.0"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3.9"
end
