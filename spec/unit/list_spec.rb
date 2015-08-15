require 'kanren/list'
require 'kanren/pair'

module Kanren
  RSpec.describe List do
    let(:array) { %i(a b c) }
    let(:list) { Pair.new(:a, Pair.new(:b, Pair.new(:c, List::EMPTY))) }

    describe '#from_array' do
      it 'turns an array into a list' do
        expect(List.from_array(array)).to eq list
      end
    end

    describe '#to_array' do
      it 'turns a list into an array' do
        expect(List.to_array(list)).to eq array
      end
    end
  end
end
