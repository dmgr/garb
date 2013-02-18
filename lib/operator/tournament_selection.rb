module Garb
  class Operator
    class TournamentSelection < self
      def initialize p, fitness, n=2
        @p = p # probability of the tournament
        @n = n # number of competitors
        @fitness = fitness
      end
      
      # other selection:
      # http://www.muehlenbein.org/analselmut95.pdf
      
      # def apply *c
        # c.max_by { |o| engine.fitness.call o }
      # end
      
      def apply_on population
        j = (population.size * @p).round
        
        population.size.times.map do |i| # Array.new(population.size) {
          if i < j
            population.sample(@n).max_by { |o| @fitness.call o }
          else
            population.sample
          end
        end
      end
    end
  end
end