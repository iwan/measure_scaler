module MeasureScaler
  module PatternDefinitions
    extend self

    def def_list
      @def_list ||= Array.new
    end
    
    def config(&block)
      instance_eval(&block)
    end

    def add(regexp)
      def_list << regexp unless def_list.include?(regexp)
    end

    def clear
      def_list.clear
    end
  end

end