module MeasureScaler
  module QuantityMethods
    Numeric.class_eval do
      def scaling_proposal
        (Math.log10(self).floor/3)*3
      end

      def scale(ord) # order of magnitude
        # TODO: raise if ord%3!=0
        to_f/10**ord
      end
    end

    Array.class_eval do
      def scaling_proposal
        (Math.log10(self).floor/3)*3
      end

      def scale(ord) # order of magnitude
        # TODO: raise if ord%3!=0
        map{|e| e.to_f/10**ord}
      end    
    end
  end
end
