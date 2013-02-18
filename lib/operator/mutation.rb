module Garb
  class Operator
    class Mutation < Unary
      attr_reader :p
      
      def initialize p
        @p = p
      end
      
      def apply c
        c.mutate p
      end
    end
  end
end