namespace :xdr do
  xdr_defs = FileList[
    "xdr/DigitalBits-types.x",
    "xdr/DigitalBits-ledger-entries.x",
    "xdr/DigitalBits-transaction.x",
    "xdr/DigitalBits-ledger.x",
    "xdr/DigitalBits-overlay.x",
    "xdr/DigitalBits-SCP.x",
  ]

  task :update, [:ref] => [:clean, :generate]
  task generate: "generated/digitalbits-base-generated.rb"

  directory "xdr"
  directory "generated"

  file "generated/digitalbits-base-generated.rb" => xdr_defs do |t|
    require "xdrgen"

    compilation = Xdrgen::Compilation.new(
      t.sources,
      output_dir: "generated",
      namespace: "digitalbits-base-generated",
      language: :ruby
    )
    IO.write("Digitalbits.x", compilation.source)
    compilation.compile
  end

  rule ".x", [:ref] => ["xdr"] do |t, args|
    args.with_defaults(ref: :master)
    core_file = github_client.contents("xdbfoundation/DigitalBits", path: "src/#{t.name}", ref: args.ref)
    IO.write(t.name, core_file.rels[:download].get.data)
  end

  task :clean do
    rm_rf "xdr"
    rm_rf "generated"
  end

  def github_client
    return @github_client if defined?(@github_client)
    require "octokit"
    @github_client = Octokit::Client.new(netrc: true)
  end
end
