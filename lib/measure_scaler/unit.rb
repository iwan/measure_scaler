module MeasureScaler
  class Unit
    attr_reader :prefix, :preunit, :unit, :direction
    def initialize(string_or_hash)
      case string_or_hash
      when String
        decode_string(string_or_hash)
      when Hash
        h = {direction: 1, preunit: nil}.merge(string_or_hash)
        @prefix    = Prefix.new(h[:prefix])
        @preunit   = h[:preunit]
        @unit      = h[:unit]
        @direction = h[:direction]

      else
        raise "attribute not valid"
      end
    end


    def pattern_found?
      !@prefix.nil?
    end

    def scale(order) # order is a multiple of 3
      definitive_order, new_prefix = @prefix.scale(order*@direction)
      # puts "--- definitive_order: #{definitive_order}, new_prefix: #{new_prefix}"
      [ definitive_order*@direction, 
        Unit.new(
          prefix: new_prefix, 
          preunit: @preunit, 
          unit: @unit, 
          direction: @direction)
      ]
    end
    
    def to_s(prefix=nil)
      "#{@preunit}#{prefix||@prefix}#{@unit}"
    end

    private

    def decode_string(s)
      @prefix    = nil
      @preunit   = nil
      @unit      = nil
      @direction = 1

      s.strip!
      PatternDefinitions.def_list.each do |regexp|
        s.match(regexp) do |md|
          # md is a MatchData obj
          case md.size
          when 3
            @prefix  = Prefix.new(md[1]) # 
            @unit    = md[2]          
          when 4
            @preunit = md[1]
            @prefix  = Prefix.new(md[2])
            @unit    = md[3]
            @direction = -1 if @preunit.include?("/")
          else
            raise "unit string decode failed"
          end
          break
        end
      end
    end
  end
end