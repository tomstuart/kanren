require 'kanren/list'
require 'kanren/micro/goal'
require 'kanren/pair'

module Kanren
  module Micro
    module Relations
      module_function

      def append(a, b, c)
        Goal.either(
          Goal.both(
            Goal.equal(a, List::EMPTY),
            Goal.equal(b, c)
          ),
          Goal.with_variables { |first, rest_of_a, rest_of_c|
            Goal.both(
              Goal.both(
                Goal.equal(a, Pair.new(first, rest_of_a)),
                Goal.equal(c, Pair.new(first, rest_of_c))
              ),
              append(rest_of_a, b, rest_of_c)
            )
          }
        )
      end
    end
  end
end
