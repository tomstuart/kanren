require 'kanren/utils'

module Kanren
  RSpec.describe Utils do
    describe '#interleave' do
      context 'when the streams are finite' do
        let(:letters) { 'a'.upto('z') }
        let(:numbers) { 1.upto(10) }

        it 'interleaves the streams' do
          expect(Utils.interleave(letters, numbers).entries).to eq ['a', 1, 'b', 2, 'c', 3, 'd', 4, 'e', 5, 'f', 6, 'g', 7, 'h', 8, 'i', 9, 'j', 10, 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        end
      end

      context 'when the streams are infinite' do
        let(:letters) { ['a', 'b', 'c'].cycle }
        let(:numbers) { 1.upto(Float::INFINITY) }

        it 'interleaves the streams' do
          expect(Utils.interleave(letters, numbers).take(20)).to eq ['a', 1, 'b', 2, 'c', 3, 'a', 4, 'b', 5, 'c', 6, 'a', 7, 'b', 8, 'c', 9, 'a', 10]
        end
      end
    end
  end
end
