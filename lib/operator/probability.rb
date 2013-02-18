module Garb
  class Operator
    class Probability < self #Unary
      def initialize operator, p
        @p = p
        @operator = operator
      end
      
      def apply_on population
        case @operator
        when Unary
          population.map { |c| rand < @p ? @operator.apply(c) : c }
        when Binary
          children = []
          
          population.each_slice(2) do |s1,s2|
            if s2
              s1,s2 = @operator.apply s1, s2 if rand < @p
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
end