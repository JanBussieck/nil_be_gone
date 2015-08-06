require 'spec_helper'

module NilBeGone

  describe Optional do
    let(:value) { double }
    let(:optional) { Optional.new(value) }

    describe '#value' do
      it 'retrieves the value from an Optional' do
        expect(optional.value).to eq value
      end
    end

    describe '#and_then' do
      context 'when the value is nil' do
        before(:example) do
          allow(value).to receive(:nil?).and_return true
        end

        it 'doesnt call the block' do
          expect { |block| optional.and_then(&block) }.not_to yield_control
        end
      end

      context 'when value is not nil' do
        before(:example) do
          allow(value).to receive(:nil?).and_return(false)
        end

        it 'calls the block with the value' do
          @value = nil
          optional.and_then { |value| @value = value }
          expect(@value).to eq value
        end

        it 'returns an object of type Optional' do
          expect(optional.and_then { 1 }).to be_an_instance_of(Optional)
        end
      end
    end
  end
end
