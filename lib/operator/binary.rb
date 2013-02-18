module Garb
  class Operator
    class Binary < self
      def apply_on population
        children = []
        
        population.each_slice(2) do |s1,s2|
          if s2
            s1, s2 = apply s1, s2
            children << s1
            children << s2
          else
            children << s1
          end
        end
        
        children
      end
    end
  end
end