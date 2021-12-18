# Checkout Coding Challenge

This repo contains a Checkout based coding challenge and a response. More details on the challenge can be found in `docs/checkout.md`

## Dependencies

The challenge response is written in Ruby.

Use a version manager to get the version of Ruby required - examples include [RVM](https://rvm.io/), [rbenv](https://github.com/rbenv/rbenv) and [Frum](https://github.com/tako8ki/frum)

Note the task specifies asks for version `2.6.6p146` which is available via rbenv as `2.6.6`.

## Installation

```
git clone https://github.com/dtt101/checkout.git
bundle install
```

## Run tests

The specific tests for the use cases in the challenge can be found in `spec/checkout_spec.rb`

```
rake test
```

## Usage

The checkout class can be created with promotional rules that apply to scanned items

```
promotional_rules = [
  DiscountTotalRule.new(applies_to: :total, minimum_spend: 60, discount_percentage: 10)
]
co = Checkout.new(promotional_rules)
co.scan(item)
co.scan(item)
price = co.total
```

## TODO

- Tests for individual rules
