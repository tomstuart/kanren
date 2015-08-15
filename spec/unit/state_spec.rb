require 'kanren/micro/state'

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
    end
  end
end
