require 'kanren/micro/variable'

module Kanren
  module Micro
    RSpec.describe Variable do
      let(:name) { :x }
      let(:different_name) { :y }

      subject(:variable) { Variable.new(name) }

      describe '#inspect' do
        it 'returns the variable’s name' do
          expect(subject.inspect).to eq name.to_s
        end
      end

      describe 'equality' do
        it 'is equal to itself' do
          expect(variable).to eq variable
        end

        it 'is not equal to a variable with a different name' do
          expect(variable).not_to eq Variable.new(different_name)
        end

        it 'is not equal to a different variable with the same name' do
          expect(variable).not_to eq Variable.new(name)
        end
      end
    end
  end
end
