module Garb
  class Applicator
    class KeepChromosome < self
      def initialize *chromosomes
        @chromosomes = chromosomes
      end
      
      def apply population
        @chromosomes.reduce(population) do |chromosome|
          if population.include? chromosome
            population
          else
            population.dup << chromosome
          end
        end
      end
    end
  end
end