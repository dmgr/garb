# require 'spec_helper'
require File.expand_path '../../lib/garb', __FILE__

class Chromosome < Array
  def fitness
    @fitness ||= count { |v| v == 1 }
  end

  def crossover c2
    cross_point = (rand * c2.size).to_i
    c1_a, c1_b = separate(cross_point)
    c2_a, c2_b = c2.separate(cross_point)
    [self.class.new(c1_a + c2_b), self.class.new(c2_a + c1_b)]
  end

  def mutate p
    mutate_point = (rand * self.size).to_i
    res = self.dup
    res[mutate_point] = 1
    res
  end
  
  def self.generate
    Chromosome.new Array.new(10).collect { rand > 0.2 ? 0 : 1 }
  end
  
  # Splits the array into two parts first from position
  # 0 to "position" and second from position "position+1" to
  # last position.
  # Returns two new arrays.
  def separate(position)
    [self[0..position], self[position+1..-1]]
  end
end

describe Garb::Engine do
  it 'default operator should works' do
    ga = Garb::Engine.new do |e|
      e.population = Array.new(20) { Chromosome.generate }
    end
    
    20.times do |i|
      ga.evolve
    end
    
    ga.best.fitness.should == 10
  end
  
  it 'custom operator should works' do
    crossover = Class.new(Garb::Operator::Binary) {
      def apply c1, c2
        cross_point = (rand * c2.size).to_i
        c1_a, c1_b = c1.separate(cross_point)
        c2_a, c2_b = c2.separate(cross_point)
        [Chromosome.new(c1_a + c2_b), Chromosome.new(c2_a + c1_b)]
      end
    }.new
    
    mutation = Class.new(Garb::Operator::Unary) {
      def apply c
        mutate_point = (rand * c.size).to_i
        res = c.dup
        res[mutate_point] = 1
        res
      end
    }.new
    
    engine = Garb::Engine.new do |e|
      e.population = Array.new(40) { Chromosome.generate }
      e.fitness = lambda { |c| c.count { |v| v == 1 } }
      e.applicator = Garb::Applicator::Pipeline.new(
        Garb::Applicator::TournamentSelection.new(0.9, e.population.size, e.fitness),
        Garb::Applicator::KeepParents.new(Garb::Applicator::Probability.new(0.2, crossover)),
        Garb::Applicator::Probability.new(0.2, mutation),
        Garb::Applicator::KeepBest.new(e),
      )
    end
    
    20.times do |i|
      # puts "--- #{ i } | #{ engine.best.fitness }---"
      engine.evolve
    end
    
    engine.best.fitness.should == 10
  end
end