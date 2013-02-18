module Garb
  class Operator
    class Shuffle < self
      def apply_on population
        population.shuffle
      end
    end
  end
end