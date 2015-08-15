require 'kanren/pair'

module Kanren
  module Peano
    ZERO, SUCC = 2.times.map { Object.new }

    module_function

    def from_integer(integer)
      if integer.zero?
        ZERO
      else
        Pair.new(SUCC, from_integer(integer.pred))
      end
    end

    def to_integer(peano)
      if peano == ZERO
        0
      else
        to_integer(peano.right).succ
      end
    end

    def to_peano(integer)
      from_integer integer
    end

    def from_peano(peano)
      to_integer peano
    end
  end
end
