require 'kanren/pair'

module Kanren
  RSpec.describe Pair do
    let(:left) { double }
    let(:right) { double }

    subject(:pair) { Pair.new(left, right) }

    describe '#inspect' do
      before(:example) do
        allow(left).to receive(:inspect).and_return 'l'
        allow(right).to receive(:inspect).and_return 'r'
      end

      it 'shows the left and right elements between parentheses' do
        expect(pair.inspect).to eq '(l, r)'
      end
    end

    describe '#left' do
      it 'returns the left element' do
        expect(pair.left).to eq left
      end
    end

    describe '#right' do
      it 'returns the right element' do
        expect(pair.right).to eq right
      end
    end
  end
end
