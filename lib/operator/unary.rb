module Garb
  class Operator
    class Unary < self
      def apply_on population
        population.map { |c| apply c }
      end
      
      def apply chromosome
      end
      
      class Applicator < Applicator
        def initialize operator
          @operator = operator
        end
        
        class Consecutive < self
          def apply population
            population.map do |c|
              @operator.apply c
            end
          end
        end
        
        class Random < self
          def apply population
            population.map do
              @operator.apply population.sample
            end
          end
        end
      end
    end
  end
end