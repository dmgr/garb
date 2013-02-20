module Garb
  class Applicator
    class Probability < self #Unary
      def initialize p, operator
        @p = p
        @operator = operator
      end
      
      def apply population
        case @operator
        when Operator::Unary
          population.map { |c| rand < @p ? @operator.apply(c) : c }
        when Operator::Binary
          children = []
          
          population.each_slice(2) do |s1,s2|
            if s2
              children.concat @operator.apply s1, s2 if rand < @p
            else
              children << s1
            end
          end
          
          children
        else raise @operator.inspect
        end
      end
    end
  end
end