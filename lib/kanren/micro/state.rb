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

      def value_of(key)
        if values.has_key?(key)
          value_of values.fetch(key)
        else
          key
        end
      end

      def unify(a, b)
        a, b = value_of(a), value_of(b)

        if a == b
          self
        elsif a.is_a?(Variable)
          assign_values a => b
        elsif b.is_a?(Variable)
          assign_values b => a
        end
      end
    end
  end
end
