require 'kanren/micro/variable'

module Kanren
  module Micro
    class State
      def initialize(variables = [], values = {})
        @variables, @values = variables, values
      end

      attr_reader :variables, :values

      def create_variables(names)
        new_variables = names.map { |name| Variable.new(name) }
        [State.new(variables + new_variables, values), new_variables]
      end

      def assign_values(new_values)
        State.new(variables, values.merge(new_values))
      end
    end
  end
end
