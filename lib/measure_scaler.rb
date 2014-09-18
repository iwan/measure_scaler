%w(
  pattern_definitions
  definitions
  errors
  prefixes
  prefix
  quantity_methods
  unit
  measure
  version
).each { |file| require File.join(File.dirname(__FILE__), 'measure_scaler', file) }


module MeasureScaler
  # Your code goes here...
end
