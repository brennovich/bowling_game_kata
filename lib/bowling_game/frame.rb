class Frame
  attr_accessor :index, :rolls

  def initialize(index)
    @index = index
    @rolls = []
  end

  def score(previous_frame = nil)
    return scored_without_bonus unless previous_frame

    if previous_frame.spare?
      scored_with_spare_bonus
    elsif previous_frame.strike?
      scored_with_strike_bonus
    else
      scored_without_bonus
    end
  end

  def roll(pins)
    @rolls << pins
  end

  def finished?
    strike? || rolls.size == 2
  end

  def strike?
    rolls.first == 10
  end

  def spare?
    rolls.size == 2 && rolls.reduce(:+) == 10
  end

  private

  def scored_without_bonus
    rolls.reduce(:+)
  end

  def scored_with_spare_bonus
    scored_without_bonus + rolls.first
  end

  def scored_with_strike_bonus
    scored_without_bonus * 2
  end
end
