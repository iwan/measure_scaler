# encoding: UTF-8
module MeasureScaler
  module Prefixes
    # http://en.wikipedia.org/wiki/Metric_prefix

    LIST = ["y", "z", "a", "f", "p", "n", "µ", "m", "", "k", "M", "G", "T", "P", "E", "Z", "Y"]
    MAX_FACTOR = 24
    MIN_FACTOR = -24
    STEP = 3

    # Get the base-10 exponent related to the symbol
    # Example: find_factor("M") # => 6 (million)
    def find_factor(symbol)
      valid?(symbol) ? (LIST.index(symbol)*STEP)+MIN_FACTOR : nil
    end

    # Get the symbol related to base-10 passed
    # The factor should be a multiple of 3, greater or equal to -24 
    # and smaller or equal to 24
    # Example: find_symbol(-3) # => "m" (thousandth)
    def find_symbol(factor)
      return nil if factor%STEP!=0 || factor<MIN_FACTOR || factor>MAX_FACTOR
      LIST[(factor-MIN_FACTOR)/STEP]
    end

    # Is a valid symbol?
    def valid?(symbol)
      LIST.include?(symbol)
    end

    # Return the list of available symbols
    def symbols_list
      LIST
    end
  end
end
