module Garb
  class Applicator
    class KeepChromosome < self
      def initialize chromosome
        @chromosome = chromosome
      end
      
      def apply population
        if population.include? @chromosome
          population
        else
          population.dup << @chromosome
        end
      end
    end
  end
end