# DigitalBIts SDK for Ruby: Frontier Integration and Higher Level Abstractions
[
This library helps you to integrate your application into the [DigitalBits network](http://digitalbits.io).

## Installation

Add this lines to your application's Gemfile:

```ruby
gem 'digitalbits-sdk'
```

And then execute:

    $ bundle

Also requires libsodium. Installable via `brew install libsodium` on OS X.

## Usage

See [examples](examples).

A simple payment from the root account to some random accounts

```ruby
require 'digitalbits-sdk'

account   = DigitalBits::Account.master
client    = DigitalBits::Client.default_testnet()
recipient = DigitalBits::Account.random

client.send_payment({
  from:   account,
  to:     recipient,
  amount: DigitalBits::Amount.new(100_000_000)
})
```

Be sure to set the network when submitting to the public network (more information in [digitalbits-base](https://www.github.com/xdbfoundation/ruby-digitalbits-base)):

```ruby
DigitalBits.default_network = DigitalBits::Networks::PUBLIC
```

## Development

- Install and activate [rvm](https://rvm.io/rvm/install)
- Ensure your `bundler` version is up-to-date: `gem install bundler`
- Run `bundle install`
- Copy `spec/config.yml.sample` to `spec/config.yml`
- Replace anything in `spec/config.yml` especially if you will re-record specs
- `bundle exec rspec spec`

## Contributing

1. Fork it ( https://github.com/xdbfoundation/ruby-digitalbits-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
