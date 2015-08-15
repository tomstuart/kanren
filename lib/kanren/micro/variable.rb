module Kanren
  module Micro
    class Variable
      def initialize(name)
        @name = name
      end

      def inspect
        @name.to_s
      end
    end
  end
end
