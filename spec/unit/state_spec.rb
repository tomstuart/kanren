require 'kanren/micro/state'
require 'kanren/pair'

module Kanren
  module Micro
    RSpec.describe State do
      before(:example) do
        @state = State.new
      end

      context 'when empty' do
        describe '#variables' do
          it 'returns an empty variable array' do
            expect(@state.variables).to be_empty
          end
        end

        describe '#values' do
          it 'returns an empty value hash' do
            expect(@state.values).to be_empty
          end
        end
      end

      context 'with declared variables' do
        before(:example) do
          @state, (@x, @y, @z) = @state.create_variables [:x, :y, :z]
        end

        describe '#variables' do
          it 'returns an array of the declared variables' do
            expect(@state.variables).to eq [@x, @y, @z]
          end
        end

        context 'with assigned values' do
          before(:example) do
            @state = @state.assign_values @x => @y, @y => @z, @z => 5
          end

          describe '#values' do
            it 'returns a hash of the assigned values' do
              expect(@state.values).to eq @x => @y, @y => @z, @z => 5
            end
          end

          describe '#value_of' do
            it 'looks up the final value of an assigned variable' do
              expect(@state.value_of(@x)).to eq 5
            end

            it 'doesn’t affect a non-variable value' do
              expect(@state.value_of(7)).to eq 7
            end

            it 'doesn’t affect an unassigned variable' do
              @state, (a, b, c) = @state.create_variables [:a, :b, :c]
              expect(@state.value_of(a)).to eq a
            end
          end
        end
      end

      describe '#unify' do
        before(:example) do
          @state, (@x, @y) = @state.create_variables [:x, :y]
        end

        it 'changes nothing if the values are already equal' do
          @state = @state.unify(@x, @x)
          expect(@state.values).to be_empty
        end

        it 'adds an assignment to the state if the first value is an unassigned variable' do
          @state = @state.unify(@x, @y)
          expect(@state.values).to eq @x => @y
        end

        it 'adds an assignment to the state if the second value is an unassigned variable' do
          @state = @state.unify(@x, @y).unify(@x, 5)
          expect(@state.values).to eq @x => @y, @y => 5
        end

        it 'fails if the values cannot be made equal' do
          @state = @state.unify(@x, @y).unify(@x, 5).unify(@y, 6)
          expect(@state).to be_nil
        end
      end

      context 'with pairs' do
        describe 'unification' do
          before(:example) do
            @state, (@x, @y) = @state.create_variables [:x, :y]
          end

          it 'successfully unifies values within pairs' do
            @state = @state.unify(Pair.new(3, @x), Pair.new(@y, Pair.new(5, @y)))
            expect(@state.values).to eq @x => Pair.new(5, 3), @y => 3
          end
        end
      end

      describe 'extracting results' do
        let(:x_value) { double }
        let(:y_value) { double }

        before(:example) do
          @state, (x, y) = @state.create_variables [:x, :y]
          @state = @state.assign_values x => x_value, y => y_value
        end

        it 'exposes the values of variables' do
          expect(@state.results(2)).to eq [x_value, y_value]
        end

        it 'exposes the value of the outermost variable' do
          expect(@state.result).to eq x_value
        end
      end
    end
  end
end
