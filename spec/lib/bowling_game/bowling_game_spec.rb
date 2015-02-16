require_relative '../../spec_helper'

RSpec.describe BowlingGame do
  subject(:game) { described_class.new }

  def roll_many(turns, pins)
    turns.times { game.roll pins }
  end

  def roll_spare
    2.times { game.roll 5 }
  end

  def roll_strike
    game.roll 10
  end

  describe '#current_frame' do
    let!(:first_frame) { game.current_frame }

    before { roll_spare }

    it 'returns the next frame with available rolls' do
      expect(game.current_frame).to_not eq first_frame
    end
  end

  describe '#score' do
    context 'when there are no scored pins' do
      before { roll_many 20, 0 }

      it 'returns 0 (zero)' do
        expect(game.score).to eq 0
      end
    end

    context 'when scored one pin for each frame' do
      before { roll_many 20, 1 }

      it 'returns 20 (twenty)' do
        expect(game.score).to eq 20
      end
    end

    context 'when spare scored' do
      before do
        roll_spare
        game.roll 3

        roll_many 17, 0
      end

      it 'doubles the next roll scored pins' do
        expect(game.score).to eq 16
      end
    end

    context 'when strike score' do
      before do
        roll_strike

        game.roll 3
        game.roll 4

        roll_many 16, 0
      end

      it 'doubles the next two rolls scored pins' do
        expect(game.score).to eq 24
      end
    end

    context 'when perfect game (strikes all frames)' do
      before { roll_many 12, 10 }

      it 'returns max score' do
        expect(game.score).to eq 300
      end
    end
  end
end
