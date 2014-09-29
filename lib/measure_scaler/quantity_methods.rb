module MeasureScaler
  module QuantityMethods
    Numeric.class_eval do
      def scaling_proposal
        (Math.log10(self).floor/3)*3
      rescue
        0.0
      end

      def scale(ord) # order of magnitude
        # TODO: raise if ord%3!=0
        to_f/10**ord
      end
    end

    Array.class_eval do
      def scaling_proposal
        a = self.map{|e| e.scaling_proposal}
        h = Hash[a.uniq.map{|e| [e,0]}] # hash for count the proposal scale
        a.each{|e| h[e]+=1}
        most_freq = h.values.max
        a = h.to_a.find_all{|e| e[1]==most_freq}.map{|e| e[0]}.sort
        a[(a.size-1)/2] # or a[a.size/2]
      end

      def scale(ord) # order of magnitude
        map{|e| e.scale(ord)}
      end    
    end
  end
end
