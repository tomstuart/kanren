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

    describe 'backwards compatibility' do
      let(:argument) { double }
      let(:result) { double }

      describe '#to_list' do
        it 'is an alias for #from_array' do
          expect(List).to receive(:from_array).with(argument).and_return(result)
          expect(List.to_list(argument)).to eq result
        end
      end

      describe '#from_list' do
        it 'is an alias for #to_array' do
          expect(List).to receive(:to_array).with(argument).and_return(result)
          expect(List.from_list(argument)).to eq result
        end
      end
    end
  end
end
