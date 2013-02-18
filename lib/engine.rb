module Garb
  class Engine
    attr_accessor :logger, :operator
    attr_reader :population, :epoch, :fitness, :best, :options 
    
    def initialize population, options={}
      @population = population
      @options = options
      @logger = options[:logger]
      @epoch = 0
      @fitness = options[:fitness] || lambda { |c| c.fitness }
      @best = _best
      
      @operator = options[:operator] || Operator::Pipeline.new(
        Operator::TournamentSelection.new(options[:p_tournament] || 0.9, @fitness),
        Operator::Crossover.new(options[:p_crossover] || 0.2),
        Operator::Mutation.new(options[:p_mutation] || 0.01)
      )
    end
    
    def evolve
      @epoch += 1
      logger.info "Epoch #{ epoch }, evolving population of #{ population.size } chromosomes..." if logger
      @population = @operator.apply_on @population
      best = _best
      logger.info "Epoch #{ epoch }, best chromosome fitness: #{ @fitness.call best }..." if logger
      @best = best if @fitness.call(best) > @fitness.call(@best)
    end
    
  private
      
    def _best
      population.max_by { |c| @fitness.call c }
    end
  end
end