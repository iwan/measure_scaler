module MeasureScaler
  class Prefix
    include Prefixes
    attr_reader :symbol, :factor

    def initialize(symbol)
      validate(symbol)

      @symbol = symbol
      @factor = find_factor(symbol)
    end

    
    def scale(proposed_order=0)
      proposed_order = align_to_3(proposed_order)
      # return the effective order and the new symbol
      new_factor = [@factor+proposed_order, MAX_FACTOR].min
      new_factor = [new_factor, MIN_FACTOR].max
      new_symbol = find_symbol(new_factor)
      effective_order  = new_factor - @factor
      [effective_order, new_symbol] # TODO: perché non ritornare [new_order, Prefix.new(new_symbol)] ?
    end

    def to_s
      @symbol
    end

    private
    def validate(symbol)
      raise PrefixError, "#{symbol} is not a valid prefix symbol" if !valid?(symbol)
    end

    def align_to_3(ord)
      if ord%3==0
        ord
      else
        (ord/3.0).round*3
      end
    end
  end
end