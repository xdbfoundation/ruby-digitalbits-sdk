# DigitalBits SDK for Ruby: XDR and Low Level Abstractions

The digitalbits-base library is the lowest-level digitalbits helper library.  It consists of classes
to read, write, hash, and sign the xdr structures that are used in digitalbits.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'digitalbits-base'
```

And then execute:

    $ bundle

Also requires libsodium. Installable via `brew install libsodium` on OS X.

## Supported Ruby Versions

Please see [CI Workflow](https://github.com/xdbfoundation/ruby-digitalbits-sdk/actions/workflows/ci.yml) for what versions of ruby are currently tested by our continuous integration system.  Any ruby in that list is officially supported.

### JRuby

It seems as though jruby is particularly slow when it comes to BigDecimal math; the source behind this slowness has not been investigated, but it is something to be aware of.

## Usage

[Examples are here](examples)

In addition to the code generated from the XDR definition files, this library also provides some digitalbits specific features.  Let's look at some of them.

We wrap rbnacl with `Digitalbits::KeyPair`, providing some digitalbits specific functionality as seen below:

```ruby

# Create a keypair from a digitalbits secret seed
signer = Digitalbits::KeyPair.from_seed("SCBASSEX34FJNIPLUYQPSMZHHYXXQNWOOV42XYZFXM6EGYX2DPIZVIA3")

# Create a keypair from a digitalbits address
verifier = Digitalbits::KeyPair.from_address("GBQWWBFLRP3BXD2RI2FH7XNNU2MKIYVUI7QXUAIVG34JY6MQGXVUO3RX")

# Produce a digitalbits compliant "decorated signature" that is compliant with digitalbits transactions

signer.sign_decorated("Hello world!") # => #<Digitalbits::DecoratedSignature ...>

```

This library also provides an impementation of DigitalBits's "StrKey" encoding (RFC-4648 Base32 + CCITT-XModem CRC16):

```ruby

Digitalbits::Util::StrKey.check_encode(:account_id, "\xFF\xFF\xFF\xFF\xFF\xFF\xFF") # => "GD777777777764TU"
Digitalbits::Util::StrKey.check_encode(:seed, "\x00\x00\x00\x00\x00\x00\x39") # => "SAAAAAAAAAADST3H"

# To prevent interpretation mistakes, you must pass the expected version byte
# when decoding a check_encoded value

encoded = Digitalbits::Util::StrCheck.check_encode(:account_id, "\x61\x6b\x04\xab\x8b\xf6\x1b")
Digitalbits::Util::StrKey.check_decode(:account_id, encoded) # => "\x61\x6b\x04\xab\x8b\xf6\x1b"
Digitalbits::Util::StrKey.check_decode(:seed, encoded) # => throws ArgumentError: Unexpected version: :account_id

```

During development of your app, you may include the [FactoryBot](https://github.com/thoughtbot/factory_bot) definitions in your specs:

```ruby
require "digitalbits-base/factories"
```

See the factories file for information on what factories are available.

## Updating Generated Code

The generated code of this library must be refreshed each time the DigitalBits network's protocol is updated.  To perform this task, run `rake xdr:update`, which will download the latest `.x` files into the `xdr` folder and will run `xdrgen` to regenerate the built ruby code.

## Caveats

The current integration of user-written code with auto-generated classes is to put it nicely, weird.  We intend to segregate the auto-generated code into its own namespace and refrain from monkey patching them.  This will happen before 1.0, and hopefully will happen soon.

## Contributing

Please [see CONTRIBUTING.md for details](../CONTRIBUTING.md).
