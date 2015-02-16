require_relative '../../spec_helper'

RSpec.describe Frame do
  subject(:frame) { described_class.new index }

  let(:index) { 1 }

  describe '#finished?' do
    context 'when there are available rolls' do
      it 'returns false' do
        expect(frame.finished?).to be false
      end
    end

    context 'when there are no available rolls' do
      before { 2.times { frame.roll 4 } }

      it 'returns true' do
        expect(frame.finished?).to be true
      end
    end

    context 'when there are no available rolls by strike' do
      before { frame.roll 10 }

      it 'returns true' do
        expect(frame.finished?).to be true
      end
    end
  end

  describe '#strike?' do
    context 'when scored 10 pins on the first roll' do
      before { frame.roll 10 }

      it 'returns true' do
        expect(frame.strike?).to be true
      end
    end

    context 'when scored a spare' do
      before { 2.times { frame.roll 5 } }

      it 'returns false' do
        expect(frame.strike?).to be false
      end
    end
  end

  describe '#spare?' do
    context 'when scored 10 pins on two rolls sum' do
      before { 2.times { frame.roll 5 } }

      it 'returns true' do
        expect(frame.spare?).to be true
      end
    end

    context 'when scored a strike' do
      before { frame.roll 10 }

      it 'returns false' do
        expect(frame.spare?).to be false
      end
    end
  end
end
