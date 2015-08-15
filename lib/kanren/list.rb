require 'kanren/pair'

module Kanren
  module List
    EMPTY = Object.new

    module_function

    def from_array(array)
      if array.empty?
        EMPTY
      else
        first, *rest = array
        Pair.new(first, from_array(rest))
      end
    end

    def to_array(list)
      if list == EMPTY
        []
      else
        first, rest = list.left, list.right
        [first, *to_array(rest)]
      end
    end

    def to_list(array)
      from_array array
    end

    def from_list(list)
      to_array list
    end
  end
end
