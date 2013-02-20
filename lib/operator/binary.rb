module Garb
  class Operator
    class Binary < self
      def apply_on population
        children = []
        
        population.each_slice(2) do |s1,s2|
          if s2
            children.concat apply s1, s2
          else
            children << s1
          end
        end
        
        children
      end
      
      class Applicator < Applicator
        def initialize operator
          @operator = operator
        end
        
        class Consecutive < self
          def apply population
            children = []
            
            population.each_slice(2) do |s1,s2|
              if s2
                children.concat @operator.apply s1, s2
              else
                children << s1
              end
            end
            
            children
          end
        end
        
        class Random < self
          def apply population
            children = []
            
            (population.size / 2).times do
              children.concat @operator.apply population.sample, population.sample
            end
            
            children
          end
        end
      end
    end
  end
end