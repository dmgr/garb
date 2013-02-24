module Garb
  class Applicator
    class Probability < self #Unary
      def initialize p, operator, keep_parents=false
        @p = p
        @operator = operator
        @keep_parents = keep_parents
      end
      
      def apply population
        children = []
        
        case @operator
        when Operator::Unary
          population.each do |c|
            children << if rand < @p
              children << c if @keep_parents
              @operator.apply(c)
            else
              c
            end
          end
        when Operator::Binary
          population.each_slice(2) do |s1,s2|
            if s2
              if rand < @p
                if @keep_parents
                  children << s1
                  children << s2
                end
                s1, s2 = @operator.apply s1, s2
              end
              children << s2
            end
            children << s1
          end
        else raise @operator.inspect
        end
        
        children
      end
    end
  end
end