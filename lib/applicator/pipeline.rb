module Garb
  class Applicator
    class Pipeline < self
      def initialize *operators
        @operators = operators.flatten
      end
      
      def apply population
        @operators.reduce(population) do |population, operator|
          operator.apply population
        end
      end
    end
  end
end