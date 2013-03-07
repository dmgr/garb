module Garb
  class Applicator
    class Pipeline < self
      attr_reader :applicators
      
      def initialize *applicators
        @applicators = applicators.flatten
      end
      
      def apply population
        @applicators.reduce(population) do |population, operator|
          operator.apply population
        end
      end
    end
  end
end