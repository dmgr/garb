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

ga = Garb::Engine.new Array.new(20) { Chromosome.generate }, logger: Logger.new(STDOUT)
    
20.times do |i|
  ga.evolve
end

ga.best
```

See a spec file for more examples.

## Licence
Copyright 2013 [@dmgr](http://github.com/dmgr)

GARB is released under the [LGPL License](http://opensource.org/licenses/LGPL-3.0)