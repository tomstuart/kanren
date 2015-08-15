module Kanren
  Pair = Struct.new(:left, :right) do
    def inspect
      "(#{left.inspect}, #{right.inspect})"
    end
  end
end
