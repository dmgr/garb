module Garb
  class Operator
    class Pipeline < self
      def initialize *operators
        @operators = operators.flatten
      end
      
      def apply_on population
        @operators.reduce(population) do |population, operator|
          operator.apply_on population
        end
      end
    end
  end
end