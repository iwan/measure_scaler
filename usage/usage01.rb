# encoding: UTF-8
require_relative '../lib/measure_scaler'


m = MeasureScaler::Measure.new(12300.456789, "MWh", 4)
puts m.inspect
puts m.to_s
# puts m.unit.inspect
m2 = m.scale
puts m2.inspect
puts m2.to_s
# puts m.scale

puts "--------------------------"

puts MeasureScaler::Measure.new(12300.456789, "€/kWh", 4).scale.to_s

puts "--------------------------"

include MeasureScaler
puts Measure.new(12300.456789, "€/kWh").scale.to_s

