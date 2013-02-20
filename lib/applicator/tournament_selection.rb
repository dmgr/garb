module Garb
  class Applicator
    class TournamentSelection < self
      def initialize p, population_size, fitness, n=2
        @p = p # probability of the tournament
        @n = n # number of competitors
        @fitness = fitness
        @population_size = population_size
      end
      
      # other selection:
      # http://www.muehlenbein.org/analselmut95.pdf
      
      # def apply *c
        # c.max_by { |o| engine.fitness.call o }
      # end
      
      def apply population
        j = (@population_size * @p).round
        
        @population_size.times.map do |i| # Array.new(population.size) {
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