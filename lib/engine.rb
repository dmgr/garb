module Garb
  class Engine
    attr_accessor :population, :logger, :applicator, :fitness, :population_size
    attr_reader :epoch, :fitness, :options, :champions 
    
    def initialize options={}
      @options = options
      @epoch = 0
      @fitness = lambda { |c| c.fitness }
      
      yield self if block_given?
      
      @population_size ||= population.size
      @champions = [_best]
      
      @applicator ||= Applicator::Pipeline.new(
        Applicator::TournamentSelection.new(options[:p_tournament] || 0.9, @population_size, @fitness),
        Applicator::KeepParents.new(Operator::Crossover::Applicator::Consecutive.new(Operator::Crossover.new(options[:p_crossover] || 0.2))),
        Operator::Mutation::Applicator::Consecutive.new(Operator::Mutation.new(options[:p_mutation] || 0.01)),
        Applicator::KeepBest.new(self),
      )
    end
    
    def evolve
      @epoch += 1
      logger.info "Epoch #{ epoch }, evolving population of #{ population.size } chromosomes..." if logger
      @population = @applicator.apply @population
      best = _best
      logger.info "Epoch #{ epoch }, best chromosome fitness: #{ @fitness.call best }..." if logger
      @champions << best if @fitness.call(best) > @fitness.call(@champions.last)
    end
    
    def best
      @champions.last
    end
    
  private
      
    def _best
      population.max_by { |c| @fitness.call c }
    end
  end
end