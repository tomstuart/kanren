require 'kanren/utils'

module Kanren
  module Micro
    class Goal
      def initialize(&block)
        @block = block
      end

      def pursue_in(state)
        @block.call state
      end

      def self.equal(a, b)
        new do |state|
          state = state.unify(a, b)

          Enumerator.new do |yielder|
            yielder.yield state if state
          end
        end
      end

      def self.with_variables(&block)
        names = block.parameters.map { |type, name| name }

        new do |state|
          state, variables = state.create_variables(names)
          goal = block.call(*variables)
          goal.pursue_in state
        end
      end

      def self.either(first_goal, second_goal)
        new do |state|
          first_stream = first_goal.pursue_in(state)
          second_stream = second_goal.pursue_in(state)

          Utils.interleave first_stream, second_stream
        end
      end
    end
  end
end
