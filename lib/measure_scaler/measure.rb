module MeasureScaler
  class Measure
    attr_reader :qty, :unit, :precision

    # Measure.new(12500.34, "MWh")
    def initialize(qty, unit, precision=nil)
      @qty, @precision = qty, precision
      @unit            = unit.is_a?(Unit) ? unit : Unit.new(unit)
    end
    
    def scale
      # TODO: gestisci unità non riconosciute (non valide)


      if @unit.pattern_found?
        ord = @qty.scaling_proposal # multipli di 3
        ord, new_unit = @unit.scale(ord)
        qty = @qty.scale(ord)
        qty = precisize(qty) if @precision
        Measure.new(qty, new_unit, @precision)
      else
        @qty = precisize(@qty) if @precision
        self
      end
    end

    def to_s
      "#{@qty} #{@unit}"
    end


    private

    # arg is an array or a numeric value
    def precisize(arg)
      if arg.is_a? Array
        arg.map{|e| precisize_num(e)}
      else
        precisize_num(arg)
      end
    end

    def precisize_num(num)
      lg = Math.log10(num.to_f).ceil
      (num.to_f*10**(@precision-lg)).round/(10.0**(@precision-lg))
    end
  end

end