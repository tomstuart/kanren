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

      describe '#pursue_in_each' do
        let(:a) { double }
        let(:b) { double }
        let(:c) { double }
        let(:a_results) { 3.times.map { double }.to_enum }
        let(:b_results) { 4.times.map { double }.to_enum }
        let(:c_results) { 5.times.map { double }.to_enum }
        let(:goal) { Goal.new }

        it 'pursues the goal in each state and interleaves the results' do
          allow(goal).to receive(:pursue_in).with(a).and_return a_results
          allow(goal).to receive(:pursue_in).with(b).and_return b_results
          allow(goal).to receive(:pursue_in).with(c).and_return c_results
          results = goal.pursue_in_each([a, b, c].to_enum)
          expect(results).to contain_exactly *a_results, *b_results, *c_results
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

      describe '.either' do
        it 'satisfies either subgoal' do
          goal = Goal.with_variables { |x| Goal.either Goal.equal(x, 5), Goal.equal(x, 6) }
          states = goal.pursue_in(State.new)

          state = states.next
          x = state.variables.first
          expect(state.values).to eq x => 5

          state = states.next
          x = state.variables.first
          expect(state.values).to eq x => 6

          expect { states.next }.to raise_error StopIteration
        end
      end
    end
  end
end
