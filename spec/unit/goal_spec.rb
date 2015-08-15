require 'kanren/micro/goal'

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
    end
  end
end
