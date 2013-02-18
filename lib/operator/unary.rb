module Garb
  class Operator
    class Unary < self
      def apply_on population
        population.map { |c| apply c }
      end
      
      def apply chromosome
      end
    end
  end
end