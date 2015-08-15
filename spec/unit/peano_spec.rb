require 'kanren/pair'
require 'kanren/peano'

module Kanren
  RSpec.describe Peano do
    let(:integer) { 3 }
    let(:peano) { Pair.new(Peano::SUCC, Pair.new(Peano::SUCC, Pair.new(Peano::SUCC, Peano::ZERO))) }

    describe '#from_integer' do
      it 'turns an integer into a Peano number' do
        expect(Peano.from_integer(integer)).to eq peano
      end
    end

    describe '#to_integer' do
      it 'turns a Peano number into an integer' do
        expect(Peano.to_integer(peano)).to eq integer
      end
    end

    describe 'backwards compatibility' do
      let(:argument) { double }
      let(:result) { double }

      describe '#to_peano' do
        it 'is an alias for #from_integer' do
          expect(Peano).to receive(:from_integer).with(argument).and_return(result)
          expect(Peano.to_peano(argument)).to eq result
        end
      end

      describe '#from_peano' do
        it 'is an alias for #to_integer' do
          expect(Peano).to receive(:to_integer).with(argument).and_return(result)
          expect(Peano.from_peano(argument)).to eq result
        end
      end
    end
  end
end
