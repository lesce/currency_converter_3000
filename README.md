# CurrencyConverter3000

This is a small interview project for converting currencies
Disclaimer : DO NOT USE IN A PRODUCTION ENVIRONMENT

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'currency_converter_3000'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install currency_converter_3000

## Usage
# Configure the currency rates with respect to a base currency (here EUR):
 
```CurrencyConverter3000::Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})
```
 
# Instantiate money objects:
 
```fifty_eur = CurrencyConverter3000::Money.new(50, 'EUR')
```
 
# Get amount and currency:
 
```fifty_eur.amount   # => 50
fifty_eur.currency # => "EUR"
fifty_eur.inspect  # => "50.00 EUR"
```
 
# Convert to a different currency (should return a Money
# instance, not a String):
 
```fifty_eur.convert_to('USD') # => 55.50 USD
```
 
# Perform operations in different currencies:
 
```twenty_dollars = CurrencyConverter3000::Money.new(20, 'USD')
```
 
# Arithmetics:
 
```fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD
```
 
# Comparisons (also in different currencies):
 
```twenty_dollars == CurrencyConverter3000::Money.new(20, 'USD') # => true
twenty_dollars == CurrencyConverter3000::Money.new(30, 'USD') # => false
 
fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true
 
twenty_dollars > CurrencyConverter3000::Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lesce/currency_converter_3000.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

