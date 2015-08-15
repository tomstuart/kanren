require 'kanren/micro/goal'
require 'kanren/micro/state'

module Kanren
  module Micro
    RSpec.describe Goal do
      describe '.new' do
        it 'doesn’t immediately yield to the block' do
          expect { |block| Goal.new(&block) }.not_to yield_control
        end
      end

      describe '#pursue_in' do
        let(:state) { double }

        it 'yields the state to the block' do
          expect { |block| Goal.new(&block).pursue_in(state) }.to yield_with_args(state)
        end
      end

      describe '.equal' do
        it 'unifies its arguments' do
          state, (x, y, z) = State.new.create_variables [:x, :y, :z]
          goal = Goal.equal(x, 5)
          states = goal.pursue_in(state)
          state = states.next
          expect(state.values).to eq x => 5
          expect { states.next }.to raise_error StopIteration
        end
      end

      describe '.with_variables' do
        it 'introduces local variables' do
          goal = Goal.with_variables { |x| Goal.equal x, 5 }
          states = goal.pursue_in(State.new)
          state = states.next
          x = state.variables.first
          expect(state.values).to eq x => 5
          expect { states.next }.to raise_error StopIteration
        end
      end
    end
  end
end
