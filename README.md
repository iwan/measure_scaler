# MeasureScaler

[![Build Status](https://travis-ci.org/iwan/measure_scaler.png)](https://travis-ci.org/iwan/measure_scaler)
[![Coverage Status](https://img.shields.io/coveralls/iwan/measure_scaler.svg)](https://coveralls.io/r/iwan/measure_scaler)
[![Code Climate](https://codeclimate.com/github/iwan/measure_scaler/badges/gpa.svg)](https://codeclimate.com/github/iwan/measure_scaler)

Simple gem to deal with measure scaling.

A couple of examples:

```ruby
include MeasureScaler

m = Measure.new(12300.456789, "MWh")
m.scale.to_s # => "12.300456789 GWh"
```
You can add precision:
```ruby
Measure.new(12300.456789, "MWh", 4).scale.to_s # => "12.3 GWh"
Measure.new(12300.456789, "MWh", 5).scale.to_s # => "12.3 GWh"
Measure.new(12300.456789, "MWh", 6).scale.to_s # => "12.3005 GWh"
```

It works with arrays too:
```ruby
Measure.new([20_000, 15_000, 8_934], "MWh").scale.qty # => [20.0, 15.0, 8.934]
Measure.new([20_000, 15_000, 8_934], "MWh").scale.unit.to_s # => "GWh"
```

And works with 'reverse' unit of measure...
```ruby
Measure.new(12300.456789, "€/kWh", 4).scale.to_s # => "12.3 €/Wh"
```

You can define your measure pattern with regexp:
```ruby
PatternDefinitions.config do
  add /^(€\/)(.?)(Wh)$/
  add /^(.?)(Wh)$/
end
```


## Installation

Add this line to your application's Gemfile:

    gem 'measure_scaler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install measure_scaler

<!-- ## Usage

TODO: Write usage instructions here
 -->
## Contributing

1. Fork it ( https://github.com/iwan/measure_scaler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
