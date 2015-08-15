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
  end
end
