module Garb
  class Applicator
    class KeepParents
      def initialize applicator
        @applicator = applicator
      end
      
      def apply population
        population + @applicator.apply(population)
      end
    end
  end
end