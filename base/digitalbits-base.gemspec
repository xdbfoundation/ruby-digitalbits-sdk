# frozen_string_literal: true

require_relative "lib/digitalbits/version"

Gem::Specification.new do |spec|
  spec.name = "digitalbits-base"
  spec.version = DigitalBits::VERSION
  spec.authors = ["Scott Fleckenstein", "Sergey Nebolsin", "Timur Ramazanov", "Aleksandr Tabachuk"]
  spec.summary = "DigitalBits client library: XDR"
  spec.homepage = "https://github.com/xdbfoundation/ruby-digitalbits-sdk"
  spec.license = "Apache-2.0"

  spec.description = <<~MSG
    The digitalbits-base library is the lowest-level digitalbits helper library. It consists of classes to read, write,
    hash, and sign the xdr structures that are used in digitalbits-core.
  MSG

  spec.files = Dir["lib/**/*", "generated/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = %w[generated lib]
  spec.bindir = "exe"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/base/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/#{spec.name}/#{spec.version}/",
    "github_repo" => spec.homepage.sub("https", "ssh"),
    "homepage_uri" => "#{spec.homepage}/tree/main/base",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}/base"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "activesupport", ">= 5.0.0", "< 8.0"
  spec.add_dependency "base32", ">= 0.3.0", "< 1.0"
  spec.add_dependency "digest-crc", ">= 0.5.0", "< 1.0"
  spec.add_dependency "rbnacl", ">= 6.0.0", "< 8.0"
  spec.add_dependency "xdr", ">= 3.0.3", "< 4.0"
end
