# Genetic Algorithms for Ruby

## Introduction

Object oriented Genetic Algorithms library for Ruby

## Example

``` ruby
require 'garb'
require 'logger'

class Chromosome
  def fitness
  end

  def crossover c2
  end

  def mutate p
  end
  
  def self.generate
  end
end

engine = Garb::Engine.new do |e|
	e.population = Array.new(20) { Chromosome.generate }
	e.logger = Logger.new(STDOUT)
end
    
20.times do |i|
  engine.evolve
end

engine.best
```

See a spec file for more examples.

## Licence
Copyright 2013 [@dmgr](http://github.com/dmgr)

GARB is released under the [LGPL License](http://opensource.org/licenses/LGPL-3.0)