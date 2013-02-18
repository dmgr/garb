module Garb
  class Operator
    class Crossover < Binary
      attr_reader :p
      
      def initialize p
        @p = p
      end
      
      def apply c1, c2
        if rand < p
          c1.crossover c2 #
        else
          [c1, c2]
        end
      end
    end
  end
end