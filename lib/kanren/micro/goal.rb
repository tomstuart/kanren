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
    end
  end
end
