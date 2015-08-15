require 'kanren/list'
require 'kanren/micro/goal'
require 'kanren/micro/relations'
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

        describe 'append' do
          it 'appends two lists' do
            goal =
              Goal.with_variables { |x|
                Relations.append(List.from_array(%w(h e)), List.from_array(%w(l l o)), x)
              }
            states = goal.pursue_in(State.new)

            results = states.map { |state| List.to_array(state.result) }
            expect(results).to eq [
              %w(h e l l o)
            ]
          end

          it 'finds the prefix which makes one list equal to another' do
            goal =
              Goal.with_variables { |x|
                Relations.append(x, List.from_array(%w(l o)), List.from_array(%w(h e l l o)))
              }
            states = goal.pursue_in(State.new)

            results = states.map { |state| List.to_array(state.result) }
            expect(results).to eq [
              %w(h e l)
            ]
          end

          it 'finds all pairs of lists which are equal to another when appended' do
            goal =
              Goal.with_variables { |x, y|
                Relations.append(x, y, List.from_array(%w(h e l l o)))
              }
            states = goal.pursue_in(State.new)

            results = states.map { |state| state.results(2).map(&List.method(:to_array)) }
            expect(results).to eq [
              [%w(), %w(h e l l o)],
              [%w(h), %w(e l l o)],
              [%w(h e), %w(l l o)],
              [%w(h e l), %w(l o)],
              [%w(h e l l), %w(o)],
              [%w(h e l l o), %w()]
            ]
          end
        end
      end
    end
  end
end
