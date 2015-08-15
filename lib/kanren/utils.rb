module Kanren
  module Utils
    module_function

    def interleave(*enumerators)
      Enumerator.new do |yielder|
        until enumerators.empty?
          loop do
            enumerator = enumerators.shift
            yielder.yield enumerator.next
            enumerators.push enumerator
          end
        end
      end
    end
  end
end
