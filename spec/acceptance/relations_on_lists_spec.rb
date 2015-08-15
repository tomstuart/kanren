require 'kanren/list'
require 'kanren/micro/goal'
require 'kanren/micro/state'

module Kanren
  module Micro
    RSpec.describe 'relations on lists' do
      describe 'equality' do
        it 'allows two lists to be unified' do
          goal = Goal.with_variables { |x, y, z| Goal.equal(List.from_array([x, 2, z]), List.from_array([1, y, 3])) }
          states = goal.pursue_in(State.new)

          state = states.next
          x, y, z = state.variables
          expect(state.values).to eq x => 1, y => 2, z => 3

          expect { states.next }.to raise_error StopIteration
        end
      end
    end
  end
end
