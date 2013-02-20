module Garb
  class Applicator
    class KeepBest < self
      def initialize engine
        @engine = engine
      end
      
      def apply population
        if population.include? @engine.best
          population
        else
          population.dup << @engine.best
        end
      end
    end
  end
end