# TireLibrary

TireLibrary is a client for Tire Library API. You can see the API documentation here: [https://developer.tirelibrary.com](https://developer.tirelibrary.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tire_library'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tire_library

## Usage

### Initialization

```ruby
client = TireLibrary::Client.new('api_key')
```

### Available Methods

Search:

```ruby
client.search(query: 'michelin' , page: 3,  type: 'makes')
```

Sizes:

```ruby
client.sizes(page: 2) # returns the page 2 of all sizes.
client.sizes(id: 33973) # returns a specific size.
client.sizes(id: 33973,  other_sizes: true) # returns all other sizes within the model of the specified tire size.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nsanta/tire_library. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TireLibrary project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tire_library/blob/master/CODE_OF_CONDUCT.md).
