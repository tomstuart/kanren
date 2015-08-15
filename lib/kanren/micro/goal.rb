module Kanren
  module Micro
    class Goal
      def initialize(&block)
        @block = block
      end

      def pursue_in(state)
        @block.call state
      end
    end
  end
end
